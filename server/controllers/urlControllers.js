import { nanoid } from "nanoid";
import Url from "../Models/url.js";

async function handelgeneratenewShorlUrl(req, res) {
  try {
    const shortId = nanoid(8);
    if (!req.body.url)
      return res.status(400).json({ error: " url is required" });
    await Url.create({
      shortId: shortId,
      redirectUrl: req.body.url,
      visitHistory: [],
      userId: req.user.id,
    });
    return res.status(200).json({ id: shortId });
  } catch (error) {
    return res.status(500).json({ error: "something went wrong while creating Url" });
  }
}

async function handeRedirectlUrl(req, res) {
  console.log("redirecting");
  const shortId = `${req.params.id}`;
  const ip = `${req.body.ip}`;
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
try {
  const shortId = `${req.params.id}`;
  const data = await Url.findOne({ shortId });
  if(data.visitHistory == []){
    return res.status(400).json({ error:"empty list" });
  }
  return res.status(200).json({ visitHistory: data.visitHistory });
} catch (error) {
  console.log(error)
  return res.status(500).json({ error:"error while getting analytics" });
}
}

export { handelgeneratenewShorlUrl, handeRedirectlUrl, handeGetAnalytics };
