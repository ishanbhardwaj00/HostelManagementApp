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
app.get('/query', (req, res) => {
  console.log(req.body)
  db.query("SELECT * FROM AUTH", (err, result) => {
    if(err) throw err
    res.status(200).send(result)
  })
}) 

app.post('/auth', (req, res) => {
  const data= req.body;
  console.log(data)
  db.query("SELECT * FROM auth WHERE id =" + req.body.id, (error, result) => {
    if(error)
      throw error;
    if(result.length==0) {
      console.log("ID not found")
    } else {
      console.log(result)
      if(result[0].password==data.password) {
        console.log("Login successful")
        res.status(200).send(JSON.stringify("success"))
      }
      else {
        console.log("Invalid ID or password")
        res.status(403).send(JSON.stringify("invalid password"))
      }
    }
  })
})

app.post('/check', (req, res) => {
  const data= req.body
  console.log(data)
  res.send(data);
})

app.post('/room', (req, res) => {
  console.log("executing")
  db.query("SELECT * from room where oid=" + req.body.oid, (error, result) => {
    if(error)
      throw error
    console.log(result)
    res.status(200).send(JSON.stringify(result))
  });
})

app.post('/feedback', (req, res) => {
  const queryString = `INSERT INTO FEEDBACK(rno, message) values ("${req.body.rno}"," ${req.body.message}")`
  db.query(queryString, (err, result) => {
    if(err)
     throw err;
    res.status(200).send(JSON.stringify(result))
  })
})

app.post('/complaint', (req, res) => {
  const queryString= `INSERT INTO COMPLAINT (rno, problem, contact_no, room_no ) values ("${req.body.rno}", "${req.body.problem}", "${req.body.contact_no}", ${req.body.room_no})`

  db.query(queryString, (err, result) => {
    if(err) throw err
    res.status(200).send(JSON.stringify(result))
  })

  console.log("SNETTNTNTN")
})

app.post('/medical', (req, res) => {
  const queryString= `INSERT INTO MEDICAL (rno, emergency, contact_no, room_no ) values ("${req.body.rno}", "${req.body.emergency}", "${req.body.contactNo}", ${req.body.roomNo})`

  db.query(queryString, (err, result) => {
    if(err) throw err;
    res.status(200).send(JSON.stringify(result))
  })

  console.log("NRGJENJV")
})

app.post('/outpass', (req, res) => {
  const queryString = `INSERT INTO OUTPASS(first_name, last_name, reason, from_destination, to_destination, address, parent_no, mode, id) values ("${req.body.firstName}","${req.body.lastName}","${req.body.reason}","${req.body.from}","${req.body.to}","${req.body.address}","${req.body.parentNo}", "${req.body.mode}", "${req.body.id}")`

  db.query(queryString, (err, result) => {
    if(err) throw err;
    res.status(200).send(JSON.stringify(result))
    console.log("DONE!")
  })
})
app.listen(3000, () => {
  console.log("Server is running on port 3000")
})
