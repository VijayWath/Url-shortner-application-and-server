import express from "express";
import {
  handelAPIgeneratenewShorlUrl,
  handeAPIRedirectlUrl,
  handeAPIGetAnalytics,
} from "../controllers/apiControllers.js";

const apiRoute = express.Router();

apiRoute.get("/:id", handeAPIRedirectlUrl);
apiRoute.post("/", handelAPIgeneratenewShorlUrl);
apiRoute.get("/analytics/:id", handeAPIGetAnalytics);

export default apiRoute;