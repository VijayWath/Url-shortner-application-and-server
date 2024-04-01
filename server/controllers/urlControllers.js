import { nanoid } from "nanoid";
import Url from "../Models/url.js";

async function handelgeneratenewShorlUrl(req, res) {
  const shortId = nanoid(8);
  if (!req.body.url)
    return res.status(400).render("home", { error: " url is required" });
  await Url.create({
    shortId: shortId,
    redirectUrl: req.body.url,
    visitHistory: [],
  });
  return res.status(200).render("home", { id: shortId });
}

async function handeRedirectlUrl(req, res) {
  console.log("redirecting");
  const shortId = `${req.params.id}`;
  const ip = `${req.ip}`;
  try {
    const entry = await Url.findOneAndUpdate(
      {
        shortId,
      },
      {
        $push: {
          visitHistory: { timestamps: Date.now(), requestIP: ip },
        },
      }
    );
    res.redirect(entry.redirectUrl);
  } catch (error) {
    console.log("error in redirecting", error);
  }
}

async function handeGetAnalytics(req, res) {
  const shortId = `${req.params.id}`;
  const data = await Url.findOne({ shortId });
  res.json({ visitHistory: data.visitHistory });
}

export { handelgeneratenewShorlUrl, handeRedirectlUrl, handeGetAnalytics };
