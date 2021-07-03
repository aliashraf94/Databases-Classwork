const express = require("express");
const app = express();
const { Pool } = require('pg');
const bodyParser = require("body-parser");
app.use(bodyParser.json());

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'cyf_hotels',
    password: 'migracode',
    port: 5432
});

// All hotels
app.get("/hotels", function(req, res) {
    pool.query("select * from hotels", (error, result)=>{
        if(result){
            res.send(result.rows) 
        } else {
            res.send(error)
        }
    });
});

// All Customers
app.get("/customers", function(req, res) {
    pool.query("select * from customers", (error, result)=>{
        if(result){
            res.send(result.rows) 
        } else {
            res.send(error)
        }
    });
});

// Add new hotel
app.post("/hotels/newHotel", function (req, res) {
    const newHotelName = req.body.name;
    const newHotelRooms = req.body.rooms;
    const newHotelPostcode = req.body.postcode;
  
    if (!Number.isInteger(newHotelRooms) || newHotelRooms <= 0) {
      return res
        .status(400)
        .send("The number of rooms should be a positive integer.");
    }
  
    pool
      .query("SELECT * FROM hotels WHERE name=$1", [newHotelName])
      .then((result) => {
        if (result.rows.length > 0) {
          return res
            .status(400)
            .send("An hotel with the same name already exists!");
        } else {
          const query =
            "INSERT INTO hotels (name, rooms, postcode) VALUES ($1, $2, $3) returning id as hotelId ";
          pool
            .query(query, [newHotelName, newHotelRooms, newHotelPostcode])
            .then((result2) => res.json(result2.rows[0]))
            .catch((e) => console.error(e));
        }
      });
  });

  // get hotel by ID
  app.get("/hotels/byId/:hotelId", (req, res) => {
      const hotelId = req.params.hotelId;
      
      pool
        .query("SELECT * FROM hotels WHERE id=$1", [hotelId])
        .then((result) => res.json(result.rows))
        .catch((error) => console.error(error))
  })

  // get hotel by its name
  app.get("/hotels/byName/:hotelName", (req, res) => {
    const hotelName = req.params.hotelName;
    
    pool
      .query(`SELECT * FROM hotels WHERE name like '%${hotelName}%'`)
      .then((result) => res.json(result.rows))
      .catch((error) => console.error(error))
})

// Update the eniter customer details
app.put("/customers/:customerId", (req, res) => {
    const customerId = req.params.customerId;

    const cName = req.body.name;
    const cEmail = req.body.email;
    const cAddress = req.body.address;
    const cCity = req.body.city;
    const cPostcode = req.body.postcode;
    const cCountry = req.body.country;

    const query = " UPDATE customers set name=$2, email=$3, address=$4, city=$5, postcode=$6, country=$7 where id=$1 "

    pool
        .query( query ,[customerId, cName, cEmail, cAddress, cCity, cPostcode, cCountry])
        .then(() => res.send(`Customer ${customerId} updated!`))
        .catch((error) => console.error(error))

})


// update specific info about customer
app.patch("/customers/:customerId", (req, res)=>{
  const customerId = req.params.customerId
  const newEmail = req.body.email

  const query = "UPDATE customers set email=$2 where id=$1"

  pool 
  .query(query, [customerId, newEmail])
  .then(() => res.send(`Customer ${customerId} email is updated! to ${newEmail}`))
  .catch((error) => console.error(error))
})

// Delets the customer by id
app.delete("/customers/:customerId", (req, res)=>{
  const customerId = req.params.customerId

  pool 
  .query("DELETE FROM bookings WHERE customer_id=$1", [customerId])
  .then(()=>{
    pool
    .query("DELETE FROM customers WHERE id=$1", [customerId])
    .then(() => res.send(`Customer ${customerId} is Deleted!`))
    .catch((error)=> console.log(error))
 })
  .catch((error)=> console.log(error))
})

app.listen(3000, function() {
    console.log("Server is listening on port 3000. Ready to accept requests!");
});