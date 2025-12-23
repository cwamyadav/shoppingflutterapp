// import: express and files of models
const express=require('express');
const Product=require('../models/product');
// const { populate } = require('dotenv');
// create router
const ProductRouter=express.Router();
// api operation, router.get/post/put/
ProductRouter.post('/api/add-product/', async(req, res)=>{
    try{
        // store at some place user input
        const{productName, productPrice, quantity,desc,category,vendorId, vendorName, subCategory,images}=req.body;
        // create product
        const product=new Product({productName, productPrice, quantity,desc,category,vendorId, vendorName,subCategory,images});
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
        return res.status(404).json({msg: "product not found"});
        }
        else{
            // if product avaiable : show the product 
          return  res.status(200).json(product);
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
        if(!product || product.length==0){
          return  res.status(404).json({msg:"product not found"});
        }
        else{
            // if product avaiable : show the product 
          return  res.status(200).json(product);
        }
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

// get product by categoryName
ProductRouter.get("/api/products-by-category/:category", async(req, res)=>{
    try{
        // the prameter passed by the user
        const {category}=req.params;
        // check that value is present or not 
        const products=await Product.find({category, popular:true});
        // if not avalible
        if(!products|| products.length==0){
            res.status(400).json({msg:"product not found"});
        }
        else{
            res.status(200).json(products);
        }
    }catch(e){
        res.status(500).json({error:e.message});
    }
});
// export in node.js
module.exports=ProductRouter;