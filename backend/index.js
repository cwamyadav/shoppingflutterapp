// import the express
const express=require('express');
const helloroute=require('./routes/hello');
const authRouter=require('./routes/auth');
const mongoose=require('mongoose');
const bannerRouter=require('./routes/banner');
const categoryRouter=require('./routes/category');
const subcategoriesRouter=require('./routes/sub_category');
const productRouter=require('./routes/product');
const productReviewRouter=require('./routes/product_review');
const cors=require('cors');
require('dotenv').config();
// defined the port 
const PORT= process.env.PORT || 3000;

// create an instance of express
// because it's entry point of backend server
const app=express();
const DB =process.env.MONGO_URL;
app.use(express.json()); // required to read JSON body
// create end point
// app.get("/hello", (req, res)=>{
//     res.send('Hello world');
// })// mongo db connection

mongoose.connect(DB).then(()=>{
    console.log('MongoDb connected');
});
// seprate route is called
app.use(cors());// enable cors for all routes and origin
app.use(helloroute);
app.use(authRouter);
app.use(bannerRouter);
app.use(categoryRouter);
app.use(subcategoriesRouter);
app.use(productRouter);
app.use(productReviewRouter);
//start the server and listen specific port
app.listen(PORT, "0.0.0.0", ()=>{
    console.log(`backend server is running on port ${PORT}`);
});