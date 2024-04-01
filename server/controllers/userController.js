import User from "../Models/";

import { createHmac } from "node:crypto";
import { HashSecrete } from "../secerets/secerates.js";

import { createToken } from "../middlewares/auth.js";

async function handelUserLogin(req, res) {
  try {
    const email = req.body.email;
    const password = req.body.password;

    const hashedPAssword = createHmac("sha256", HashSecrete)
      .update(password)
      .digest("hex");

    const user = User.findOne({ email: email });
    if (!user) {
      return res.json({ error: "User not found please create account" });
    }
    if (user.password != hashedPAssword) {
      return res.json({ error: "Please enter a valid password" });
    }
    const token = createToken(user);
    return res.json({ user: user, token: token });
  } catch (error) {
    console.log(error)
    return res.json({error:"Someting went wrong while Login"})
  }
}
