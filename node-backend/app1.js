const express= require('express')
const mysql= require('mysql')


const db= mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'welcome',
  database: 'HostelOP'
})

db.connect((e) => {
  if(e) {
    throw e;
  }
  console.log("Database connected")
})

const app= express()
app.use(express.json());

app.post('/', (req,res))