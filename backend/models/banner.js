const mongoose=require('mongoose');// import
const bannerSchema=mongoose.Schema(// creating a banner schema
    {image:{
        type: String, 
        required: true, 
    }}
);

const Banner=mongoose.model("Banner", bannerSchema);// creating a model with bannerschema
module.exports=Banner;// this allows banners used in other files