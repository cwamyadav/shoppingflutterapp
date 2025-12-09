// import: express and files of models
const express=require('express');
const Product=require('../models/product');
const { populate } = require('dotenv');
// create router
const ProductRouter=express.Router();
// api operation, router.get/post/put/
ProductRouter.post('/api/add-product/', async(req, res)=>{
    try{
        // store at some place user input
        const{productName, productPrice, quantity,desc,subCategory,image,popular,recommend}=req.body;
        // create product
        const product=new Product({productName, productPrice, quantity,desc,subCategory,image,popular,recommend});
        // save the mongodb
        await product.save();
        // response of the server
        res.status(201).send(product);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});
ProductRouter.get('/api/popular-products/',async(req, res)=>{
    try{
        // check the condition of product
        const product=await Product.find({popular:true});
        //if product not avaialbe 
        if (!product || product.length === 0) {
        return res.status(404).json({ msg: "product not found" });
        }
        else{
            // if product avaiable : show the product 
          return  res.status(200).json({product});
        }
    }catch(e){
        res.status(500).json({error: e.message});
    }
});
ProductRouter.get('/api/recommend-products/',async(req, res)=>{
    try{
        // check the condition of product
        const product=await Product.find({recommend:true});
        //if product not avaialbe 
        if(!product || product.lenght==0){
          return  res.status(404).json({msg:"product not found"});
        }
        else{
            // if product avaiable : show the product 
          return  res.status(200).json({product});
        }
    }catch(e){
        res.status(500).json({error: e.message});
    }
});
// export in node.js
module.exports=ProductRouter;