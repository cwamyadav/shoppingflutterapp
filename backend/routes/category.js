const express=require('express');
const Category=require('../models/category');
const categoryRouter=express.Router();
categoryRouter.post('/api/categories/', async(req,res)=>{
    try{
        const {name, image, banner}=req.body;
        const category=new Category({name, image, banner});
        await category.save();
        res.status(201).send(category);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

// Route: Get all categories
categoryRouter.get('/api/categories/', async (req, res) => {
    try {
        // Fetch all category documents from the database
        const categories = await Category.find();

        // Send the list of categories with a success status
        return res.status(200).send(categories);
    } catch (e) {
        // Send error response if something goes wrong
        return res.status(500).json({ error: e.message });
    }
});

module.exports=categoryRouter; 