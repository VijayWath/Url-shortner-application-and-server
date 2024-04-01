import mongoose from "mongoose";

const urlSchema = new mongoose.Schema(
  {
    shortId: {
      type: String,
      required: true,
      unique: true,
    },
    userId:{
      type: mongoose.Schema.Types.ObjectId,
      ref:api-users
    }
    ,
    redirectUrl: {
      type: String,
      required: true,
    },
    visitHistory: [
      {
        timestamps: { type: Number },
        requestIP: { type: String },
      },
    ],
  },
  { timestamps: true }
);

const Url = mongoose.model("url", urlSchema);

export default Url;
