const mongoose=require("mongoose");
const ratingSchema = require("./ratings");

const productSchema=mongoose.Schema({
    name:{
        required:true,
        type:String,
        trim:true
    },
    description:{
        required:true,
        trim:true,
        type:String,
    },
    price:{
        required:true,
        type:Number,
        
    },
    quantity:{
        required:true,
        type:Number,
    },
    category:{
        required:true,
        type:String,
        trim:true
    },
    imageUrl:[{
        required:true,
        type:String,
    },
],
    ratings:[ratingSchema]

});

const Product=mongoose.model("Product",productSchema);
module.exports={Product,productSchema};