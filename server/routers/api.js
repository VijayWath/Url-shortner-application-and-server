import express from "express";
import {
  handelgeneratenewShorlUrl,
  handeRedirectlUrl,
  handeGetAnalytics,
  handeGetAllUrl
} from "../controllers/urlControllers.js";

const apiRoute = express.Router();

apiRoute.get("/:id", handeRedirectlUrl);
apiRoute.post("/", handelgeneratenewShorlUrl);
apiRoute.get("/analytics/:id", handeGetAnalytics);
apiRoute.get("/user/allurl",handeGetAllUrl)

export default apiRoute;
