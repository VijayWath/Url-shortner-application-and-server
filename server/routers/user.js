import express from "express";
import {
  handelUserLogin,
  handelUserSignUp,
} from "../controllers/userController.js";
const userRouter = express.Router();

userRouter.post("/login", handelUserLogin);
userRouter.post("/signup", handelUserSignUp);

export default userRouter;
