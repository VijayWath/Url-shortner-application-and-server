import jwt from "jsonwebtoken";
import { jwtPasswordKey } from "../secerets/secerates.js";

async function checkForAuth(req, res, next) {
  try {
    req.user = null;
    const authToken = req.header("x-auth-token");
    if (!authToken) return res.status(404).json({ error: "NO auth Token" });

    const user = jwt.verify(authToken, jwtPasswordKey);
    if (!user) return res.status(404).json({ error: "auth Token Not Verifid" });

    req.user = user;
    req.token = authToken;
    
    next();
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
}

async function createToken(user){
  try{
    const {_id,name,email} = user;

    const  payload = {
      id:_id,
      name:name,
      email:email
    }

    const token = jwt.sign(payload,jwtPasswordKey);

    return token
  }catch(e){
    console.log("error while creating token:"+error)
  }
}

export{checkForAuth,createToken} 
