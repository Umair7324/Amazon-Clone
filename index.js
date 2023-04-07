const express = require("express");
const productRouter = require("./routes/product");
const authRouter = require("./routes/auth");
const app = express();
const adminRouter=require("./routes/admin");
const mongoose=require('mongoose');
const userRouter = require("./routes/user");



    

const PORT=3000;

const DB="mongodb://Umair:umair24171@ac-uyyfdy6-shard-00-00.tfxstyo.mongodb.net:27017,ac-uyyfdy6-shard-00-01.tfxstyo.mongodb.net:27017,ac-uyyfdy6-shard-00-02.tfxstyo.mongodb.net:27017/?ssl=true&replicaSet=atlas-h6bj1h-shard-0&authSource=admin&retryWrites=true&w=majority";
mongoose.set('strictQuery', false);


//for middleWAre
app.use(express.json());
app.use(productRouter);
app.use(authRouter);
app.use(adminRouter);
app.use(userRouter);




app.listen(PORT,"0.0.0.0",()=>{
    console.log(`hn bhai connect hua`);
});


mongoose.connect(DB).then(()=>{console.log("connection successful");}).catch((e)=>{
    console.log(e);
});



