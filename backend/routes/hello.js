const express = require('express');
const helloroute = express();
helloroute.get('/hello', (req, res)=>{
    res.send('Hello world how are you ji');
});
module.exports=helloroute;