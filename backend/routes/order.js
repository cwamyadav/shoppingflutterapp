const express=require('express');
const Order=require('../models/order');
const OrderRouter=express.Router();

OrderRouter.post('/api/orders/', async(req,res)=>{
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


// get method 
OrderRouter.get('/api/orders/:buyerId', async(req,res)=>{
    try{
        // extract parameters
        const{buyerId}=req.params;
        // check the params 
        const orders= await Order.find({buyerId});
        // retrun 
        if(orders.length==0){
            // no order found with this buyer id
            return res.status(404).json({msg:'no order found for this buyer'});
        }
            return res.status(200).json(orders);
       
    }catch(e){
        return res.status(500).json({error:e.message});
    }
});



// Delete the id 
OrderRouter.delete('/api/orders/:id', async(req,res)=>{
    try{
        // extract the parameter form the request 
        const{id}=req.params;
        // delete 
        const deletedOrder= await Order.findByIdAndDelete(id);
        // return
        if(!deletedOrder){
            return res.status(404).json({msg:"order not found"});
        }else{
            return res.status(200).json({msg:"order was deleted successfully"});
        }
    }catch(e){
        return res.status(500).json({error:e.message});
    }
})




OrderRouter.get('/api/orders/vendors/:vendorId', async(req,res)=>{
    try{
        // extract parameters
        const{vendorId}=req.params;
        // check the params 
        const orders= await Order.find({vendorId});
        // retrun 
        if(orders.length==0){
            // no order found with this buyer id
            return res.status(404).json({msg:'no order found for this vendor'});
        }
        
            return res.status(200).json(orders);
       
    }catch(e){
        return res.status(500).json({error:e.message});
    }
});


module.exports=OrderRouter;