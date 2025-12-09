const mongoose=require('mongoose');
const productSchema=mongoose.Schema({
    productName:{
        type: String, 
        required: true, 
        trim: true,
    }, 
    productPrice:{
        type: Number, 
        required: true, 
    }, 
    quantity:{
        type: Number, 
        required: true, 
    },
    desc:{
        type: String, 
        required: true, 
    },
    subCategory:{
        type: String, 
        required: true, 
    },
    image:[{
        type: String, 
        required: true, 
    }, ], 
    popular:{
        type: Boolean, 
        default: true, 
    }, 
    recommend:{
        type: Boolean, 
        required: true, 
    }, 


});
const Product=mongoose.model("Product", productSchema);
module.exports=Product;