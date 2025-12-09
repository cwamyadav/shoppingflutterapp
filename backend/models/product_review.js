// import mongoose 
const mongoose=require('mongoose');
// create schema 
const ratingReviewSchema=mongoose.Schema({
    buyerId:{
        type: String, 
        required: true,
    }, 
    email:{
        type: String, 
        required:true,
    }, 
    fullname:{
        type:String, 
        required: true,
    }, 
    productId:{
        type:String, 
        required: true, 
    }, 
    rating:{
        type: Number, 
        required:true,
    },
    review:{
        type: String, 
        required:true,
    }

});
// create model 
const ProductReview=mongoose.model("ProductReview", ratingReviewSchema);
// export that model 
module.exports=ProductReview;