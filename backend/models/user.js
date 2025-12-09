// import mongoose(library of mongoose)
const mongoose=require('mongoose');
//create the schema(how to data organise overall structure)
const UserSchema=mongoose.Schema({
    // email
    email:{
        type: String, 
        required: true, 
        trim: true,
        validate:{
            validator:(value)=>{
            const result=/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return result.test(value);  
            },
            message: 'enter a valid email'
        }
    },
    // name
    fullname:{
        type: String, 
        required: true, 
        trim: true, 
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
    }

});
//schema convert into models
const User =mongoose.model("User", UserSchema);
//make such way model access whole inside node.js project
module.exports=User;