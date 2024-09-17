const express = require('express');
const userRoutes = require('./routes/userRouter');
const bodyParser = require("body-parser");

const app = express();
const PORT = process.env.PORT || 3000;
app.use(bodyParser.json());


app.use('/user', userRoutes);

app.listen(PORT, ()=> {
   console.log(`Server is running on port ${PORT} http://localhost:${PORT}`);
});