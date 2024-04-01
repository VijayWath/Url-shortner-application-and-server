import express from "express";
import bodyParser from "body-parser";

import { connectToDb } from "./connections.js";
import {DB} from "./secerets/secerates.js";

import apiRoute from "./routers/api.js";
import userRouter from "./routers/user.js";

import { checkForAuth } from "./middlewares/auth.js";

const app = express();
const port = process.env.port | 3000;

connectToDb(DB).then(() => {
  console.log("DB connected");
});

app.use(bodyParser.urlencoded({ extended: false }));

app.use("/api",checkForAuth,apiRoute);
app.use("/user",userRouter);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
})