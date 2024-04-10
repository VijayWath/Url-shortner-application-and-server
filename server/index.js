import express from "express";
import bodyParser from "body-parser";

import { connectToDb } from "./connections.js";
import { DB } from "./secerets/secerates.js";

import apiRoute from "./routers/api.js";
import userRouter from "./routers/user.js";
import {handelGetUser} from "./controllers/userController.js"

import { handeRedirectlUrl } from "./controllers/urlControllers.js";
 
import { checkForAuth } from "./middlewares/auth.js";

const app = express();
const port = process.env.PORT || 3000; 

connectToDb(DB).then(() => {
  console.log("DB connected");
});

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({ extended: false }));

app.use("/api", checkForAuth, apiRoute);
app.use("/user", userRouter);

app.get("/:id",handeRedirectlUrl)

app.get("/",checkForAuth,handelGetUser)

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
