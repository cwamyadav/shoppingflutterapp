    // import the express and route
    const express=require('express');
    const ProductReview=require('../models/product_review');
    const Product=require('../models/product');
    // create router 
    const ReviewRatingRouter=express.Router();
    // create api
    ReviewRatingRouter.post('/api/prodcut-review', async(req, res)=>{
        try{
            const{buyerId,email,fullname,productId,rating,review}=req.body;

            // check if product already revievwed the product
            const existingReview=await ProductReview.findOne({buyerId, productId});

            if(!existingReview){
                return res.status(400).json({msg:"you have already reviewed this product"});
            }
            const reviews= new ProductReview({buyerId,email,fullname,productId,rating,review});
            // save the mongodb
        await reviews.save();
        

        // find the product associated with the review using the productid
        const product=await Product.findById(productId);
        // if the proecut was not found, return a 404 error response 
        if(!product){
            return res.status(404).json({msg:"product not found"});
        }
        // update the total ra tings by incrementing it by 1
        product.totalRatings+=1;

        product.averageRating=((product.averageRating*(product.totalRatings-1))+rating)/product.totalRatings;
        
        await product.save();
        return res.status(201).send(reviews);
        }catch(e){
            return res.status(500).json({"error":e.message});
        }
    });

    ReviewRatingRouter.get('/api/reviews', async(req, res)=>{
        try{
            // condition check 
            const reviews=await ProductReview.find();
            // return accoring to use 
            return res.status(200).json({reviews});
        }catch(e){
            res.status(500).json({error: e.message});
        }
    });
    // api export in node.js project
    module.exports=ReviewRatingRouter;