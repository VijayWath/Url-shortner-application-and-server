import User from "../Models/user.js";

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

    const user = await User.findOne({ email: email });
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    if (user.password != hashedPAssword) {
      return res.status(404).json({ error: "Invalid password" });
    }
    const token = createToken(user);
    return res.status(200).json({ user: user, token: token });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error: "Someting went wrong while Login" });
  }
}

async function handelUserSignUp(req, res) {
  const email = req.body.email;
  const password = req.body.password;
  const name = req.body.name;

  const hashedPAssword = createHmac("sha256", HashSecrete)
    .update(password)
    .digest("hex");

  try {
    const user = await User.findOne({ email: email });
    if (!user) {
      const user = await User.create({
        name: name,
        email: email,
        password: hashedPAssword,
      });

      const token = createToken(user);

      return res.status(200).json({ user: user, token: token });
    } else {
      return res.status(404).json({ error: "user already exists" });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error: "Someting went wrong while Login" });
  }
}

export { handelUserLogin, handelUserSignUp };
