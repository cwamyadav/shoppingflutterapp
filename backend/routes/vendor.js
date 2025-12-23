const express = require('express');
const Vendor = require('../models/vendor');
const bcrypt = require('bcryptjs');
const jwt=require('jsonwebtoken');


// create the router 
const vendorRouter=express.Router();
// call the api post or get
vendorRouter.post('/api/vendor/signup', async(req, res)=>{
    try{
    // what things i send to server
    const {fullname,email,password}=req.body;

    const existingEmail=await Vendor.findOne({email});

    if(existingEmail){
        return res.status(400).json({msg:"vendor with same email already exist"});
    }else{
    // generate a salt with const factor 10
    const salt= await  bcrypt.genSalt(10);
    // hash password using the generate salt 
    const hashedPassword= await bcrypt.hash(password,salt);
    let vendor=new Vendor({fullname,email,password:hashedPassword});
    // save the mongodb
   vendor=await vendor.save();

    // send the response 
    res.status(201).send(vendor);
    }
    }
    catch(e){
        res.status(500).json({message:e.message});
    }
});

vendorRouter.post('/api/vendor/signin', async(req,res)=>{
    try{
        const{email, password}=req.body;
        // check that email is present or not 
        const findVendor=await Vendor.findOne({email});
        
        if(!findVendor){
            res.status(400).json({msg:"this email is not exist"});
        }
        // check the password
        else{
            // check password
            const isMatch=await bcrypt.compare(password, findVendor.password);
            if(!isMatch){
                res.status(400).json({msg:"Incorrect password"});
            }
            else{
                const token=jwt.sign({id: findVendor._id}, process.env.JWT_SECRET);
                const {password,  ...vendorWithoutPassword}=findVendor._doc;
                res.json({token, vendor:vendorWithoutPassword} );
            }
        }

    }catch(error){
        res.status(500).json({error:error.message});
    
    }
})
module.exports=vendorRouter;


