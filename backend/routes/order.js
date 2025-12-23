const express=require('express');
const Order=require('../models/order');
const OrderRoute=express.Router();

OrderRoute.post('/api/orders/', async(req,res)=>{
    try{
        const{
            fullName,
            email,
            state,
            city,
            locality,
            productName,
            productPrice,
            quantity,
            category, 
            image,
            buyerId,
            vendorId,
            }=req.body;

    const createdAt=new Date().getMilliseconds();
    const order=new Order({
            fullName,
            email,
            state,
            city,
            locality,
            productName,
            productPrice,
            quantity,
            category, 
            image,
            buyerId,
            vendorId,
            createdAt
});

// save to mongodb
await order.save();

return res.status(201).json(order);
    }catch(e){
    return res.status(500).json({error:e.message});
    }
    
});
module.exports=OrderRoute;