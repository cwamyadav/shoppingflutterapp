    // import the express and route
    const express=require('express');
    const ProductReview=require('../models/product_review');
    // create router 
    const ReviewRatingRouter=express.Router();
    // create api
    ReviewRatingRouter.post('/api/prodcut-review/', async(req, res)=>{
        try{
            const{buyerId,email,fullname,productId,rating,review }=req.body;
            const reviews= new ProductReview({buyerId,email,fullname,productId,rating,review });
            // save the mongodb
        await reviews.save();
            // return the product 
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
    })
    // api export in node.js project
    module.exports=ReviewRatingRouter;