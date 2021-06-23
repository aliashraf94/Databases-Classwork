const express = require("express");
const app = express();
const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'cyf_classes',
    password: 'migracode',
    port: 5432
});

app.get("/hello", function(req, res) {
   res.send("hello World")
});


app.get("/hotels", function(req, res) {
    pool.query("select * from hotels", (error, result)=>{
        if(result){
            res.send(result.rows) 
        } else {
            res.send(error)
        }
    });
});

app.listen(3000, function() {
    console.log("Server is listening on port 3000. Ready to accept requests!");
});