const express=require('express');
const User=require('../models/user');
const bcrypt=require('bcryptjs');
const jwt=require('jsonwebtoken');
const authRouter=express.Router();// create the route for login and signup
// take thedata from user and send to server
authRouter.post('/api/signup/', async(req, res)=>{
    // handle the post request at url
    try{
        const {fullname, email, password}=req.body;// req body contain data name email passowrd, 
        // Uses MongoDB to check if a user with the same email already exists.
        const existingEmail=await User.findOne({email});
        // findOne -findOne() returns a user object if found or null if not.

        if(existingEmail){
            return res.status(400).json({msg: 'user with same email already exist'});
        }
        else{
            // generate a salt with a coast  factor of 10
            const salt=await bcrypt.genSalt(10);
            // hash the password  using the  generated salt
            const hashPassword=await bcrypt.hash(password, salt);
            let user = new User({fullname, email, password: hashPassword});// create user
            user=await user.save();// save into database
            res.json({user});// respond with saved object
        }
    }catch(e){
       res.status(500).json({error:e.message});
    }
});
authRouter.post('/api/signin/',async (req, res)=> {
    try{
        const {email, password}=req.body;
        const findUser=await User.findOne({email});
        if(!findUser){
            return res.status(400).json({msg:"User not found with this email"});
        }else{
            // password comparison 
            const isMatch=await bcrypt.compare(password, findUser.password);
            if(!isMatch){
                return res.status(400).json({msg: "Incorrect passowrd"});
            }else{
                const token=jwt.sign({id: findUser._id}, process.env.JWT_SECRET);
                // remove senesetive information 
                const {password,  ...userWithoutPassword}=findUser._doc;
                // send the response
                res.json({token, ...userWithoutPassword});
            }
        }
    }catch(error){
        res.status(500).json({error:error.message});
    }
});
module.exports=authRouter;//any where used in backend