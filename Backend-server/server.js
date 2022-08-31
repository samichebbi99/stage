require("dotenv").config();
// Import express
let express = require('express');
// Import Body parser
let bodyParser = require('body-parser');
// Import Mongoose
let mongoose = require('mongoose');
var cors = require('cors');
// Initialise the app
let app = express();
app.use(cors());  
// Import routes
let apiRoutes = require("./routes/api-routes");
// Configure bodyparser to handle post requests
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());
app.use(express.static(__dirname + '/uploads/'));

// Connect to Mongoose and set connection variable
mongoose.connect('mongodb+srv://test123:test123@cluster0.n5rkk6q.mongodb.net/starwars?retryWrites=true&w=majority', { useNewUrlParser: true});
var db = mongoose.connection;

// Added check for DB connection
if(!db)
    console.log("Error connecting db")
else
    console.log("Db connected successfully")

// Setup server port
var port = process.env.PORT || 3000;

// Send message for default URL
app.get('/', (req, res) => res.send('Hello World with Express'));

// Use Api routes in the App
app.use('/api', apiRoutes);

app.use('/uploads',express.static('uploads'))

// Launch app to listen to specified port
app.listen(port, function () {
    console.log("Running on port " + port);
});
