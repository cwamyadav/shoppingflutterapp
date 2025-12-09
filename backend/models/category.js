const express=require('express');
const mongoose=require('mongoose');
// create schema=structure of data
const CategorySchema=mongoose.Schema({
    name:{
        type: String, 
        required : true, 
    }, 
    // image
    image:{
        type: String, 
        required : true, 
    }, 
    banner: {
        type: String, 
        required : true,
    }
});
// create model 
const Category=mongoose.model('category', CategorySchema);
// export to whole node.js
module.exports=Category;
