import { nanoid } from "nanoid";
import Url from "../Models/url.js";

async function handelAPIgeneratenewShorlUrl(req, res) {
  const shortId = nanoid(8);
  if (!req.body.url)
    return res.status(400).render("home", { error: " url is required" });
  await Url.create({
    shortId: shortId,
    redirectUrl: req.body.url,
    visitHistory: [],
  });
  return res.status(200).json({ id: shortId });
}

async function handeAPIRedirectlUrl(req, res) {
  const shortId = `${req.params.id}`;
  const ip = req.ip;
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
  res.json({ redirectUrl: entry.redirectUrl });
}

async function handeAPIGetAnalytics(req, res) {
  const shortId = `${req.params.id}`;
  const data = await Url.findOne({ shortId });
  res.json({ visitHistory: data.visitHistory });
}

export {
  handelAPIgeneratenewShorlUrl,
  handeAPIRedirectlUrl,
  handeAPIGetAnalytics,
};
