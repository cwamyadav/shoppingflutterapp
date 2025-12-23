// steps for creating the model

const mongoose=require('mongoose');
// import mongoose 

// create schema
const vendorSchema=mongoose.Schema({
    // name
    fullname:{
        type: String, 
        required: true, 
        trim: true, 
    },
     email:{
        type: String, 
        required: true, 
        trim: true,
        lowercase:true,
        validate:{
            validator:(value)=>{
            const result=/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return result.test(value);  
            },
            message: 'enter a valid email'
        }
    },
    // state(optional)
    state:{
        type: String, 
        default: ""
    },
    // locality(optional)
    locality:{
        type: String, 
        default:""
    },
    role:{
        type: String, 
        default:"vendor"
    },
    city:{
        type: String, 
        default: ""
    }, 
    // password
     password:{
        type: String, 
        required: true, 
        validate: {
        validator: (value) => value.length >= 8,
        message: 'password must be at least 8 characters'
        }
    },
});
// create  model
const Vendor=mongoose.model("Vendor", vendorSchema);
// export whole node js project 
module.exports=Vendor;

