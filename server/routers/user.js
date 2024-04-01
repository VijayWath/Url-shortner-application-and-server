import express from "express";
import {handelUserLogin,handelUserSignUp,handelUserSignUp} from "../controllers/userController.js"
const userRouter = express.Router();

userRouter.post("/login",handelUserLogin);
userRouter.post("/signup",handelUserSignUp);
userRouter.post("/logout",handelUserSignUp)

export default userRouter;