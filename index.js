const express = require('express'),
app = express(),
morgan = require('morgan'),  
bodyParser = require('body-parser'),
uuid = require("uuid"),
mongoose = require('mongoose');


//imports models
const Models = require('./models.js');

// imports users and movies
const Movies = Models.Movie;
const Users = Models.User;
const Genres = Models.Genre;
const Directors = Models.Director;


//Database connection
 mongoose.connect(process.env.CONNECTION_URI , { 
  //mongoose.connect('mongodb://localhost:27017/myFlixDB', { 
    useNewUrlParser: true, 
  useUnifiedTopology: true, 
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const cors = require('cors');
app.use(cors());

const { check, validationResult } = require('express-validator');

let auth = require('./auth')(app);
const passport = require('passport');
require('./passport');

// logging with morgan (middleware)
app.use(morgan("common"));


// allows user to register
app.post('/users', 
[
  check('Username', 'Username is required').isLength({min: 5}),
  check('Username', 'Username contains non alpanumeric characters - not allowed.').isAlphanumeric(),
  check('Password', 'Password is required').not().isEmpty(),
  check('Email', 'Email does not appear to be valid').isEmail()
],(req, res) => {
  let errors = validationResult(req);

  if (!errors.isEmpty()){
    return res.status(422).json({
      errors: errors.array() });
  }

  let hashedPassword = Users.hashPassword(req.body.Password);
  Users.findOne({ Username: req.body.Username })
    .then((user) => {
      if (user) {
        return res.status(400).send(req.body.Username + 'already exists');
      } else {
        Users
          .create({
            Username: req.body.Username,
            Password: hashedPassword,
            Email: req.body.Email,
            Birthday: req.body.Birthday
          })
          .then((user) =>{res.status(201).json(user) })
        .catch((error) => {
          console.error(error);
          res.status(500).send('Error: ' + error);
        })
      }
    })
    .catch((error) => {
      console.error(error);
      res.status(500).send('Error: ' + error);
    });
});

// Get all users
app.get('/users', (req, res) => {
  Users.find()
    .then((users) => {
      res.status(200).json(users);
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send('Error: ' + err);
    });
});
    

// allows users to update their info
// UPDATE
app.put('/users/:id', (req, res) => {
  const { id } = req.params;
  const updatedUser = req.body;

 let user = users.find( user => user.id == id);

if (user) {
      user.name = updatedUser.name;
      res.status(200).json(user);
} else {
  res.status(400).send('no user found')
}
});

app.put('/users/:Username', (req, res) => {
  Users.findOneAndUpdate({ Username: req.params.Username }, { $set:
    {
      Username: req.body.Username,
      Password: req.body.Password,
      Email: req.body.Email,
      Birthday: req.body.Birthday
    }
  },
  { new: true }, // This line makes sure that the updated document is returned
  (err, updatedUser) => {
    if(err) {
      console.error(err);
      res.status(500).send('Error: ' + err);
    } else {
      res.json(updatedUser);
    }
  });
});

// // allows users to add a movie to their favorites
// // POST
app.post('/users/:id/:movieTitle', (req, res) => {
  const { id, movieTitle } = req.params;

 let user = users.find( user => user.id == id);

if (user) {
      user.favoriteMovies.push(movieTitle);
      res.status(200).send(`${movieTitle} has been added to user ${id}'s array`);;
} else {
  res.status(400).send('no user found')
}
});

// // allows users to delete a movie
// // DELETE
app.delete('/users/:id/:movieTitle', (req, res) => {
  const { id, movieTitle } = req.params;

 let user = users.find( user => user.id == id);

if (user) {
      user.favoriteMovies = user.favoriteMovies.filter( title => title !== movieTitle);
      res.status(200).send(`${movieTitle} has been removed from user ${id}'s array`);;
} else {
  res.status(400).send('no user found')
}
});

// // allows users to deregister
// // DELETE
app.delete('/users/:id', (req, res) => {
  const { id } = req.params;

 let user = users.find( user => user.id == id);

if (user) {
      user = users.filter( user => user.id !== id);
      res.status(200).send(`user ${id} has been deleted`);;
} else {
  res.status(400).send('no user found')
}
});




// returns list of all movies to user
// READ
app.get('/movies', passport.authenticate('jwt', { session: false }), (req, res) => {
  Movies.find()
    .then((movies) => {
      res.status(201).json(movies);
    })
    .catch((error) => {
      console.error(error);
      res.status(500).send('Error: ' + error);
    });
});

  // Gets the data about a single movie by title
  // READ
app.get('/movies/:title', passport.authenticate('jwt', {session: false}), (req, res) => {
  res.json(movies.find((movies) =>
    { return movies.title === req.params.title }));
});

// //Gets the data by genre
// // READ
app.get('/movies/genre/:genreName', passport.authenticate('jwt', {session: false}), (req, res) => {
  const { genreName } = req.params;
  const genre = movies.find(movie => movie.genre.name === genreName).genre;

  if (genre) {
      res.status(200).json(genre);
  } else {
      res.status(400).send("genre not found")
  }
});

// // gets the data about the director
// // READ
app.get('/movies/director/:directorName',passport.authenticate('jwt', {session: false}), (req, res) => {
  const { directorName } = req.params;
  const director = movies.find(movie => movie.director.name === directorName).director;

  if (director) {
      res.status(200).json(director);
  } else {
      res.status(400).send("director not found")
  }
});

app.get("/documentation", (req, res) => {                  
  res.sendFile("public/documentation.html", { root: __dirname });
});


const port = process.env.PORT || 8080;
app.listen(port, '0.0.0.0', () => {
  console.log('Listening on Port' + port);
});


// mongosh "mongodb+srv://ashli-cluster.dlfjrip.mongodb.net/myFlixDB" --apiVersion 1 --username Ashli-Vaccaro


// mongodb+srv://Ashli-Vaccaro:HaHBK7bErWA8AXyX@ashli-cluster.dlfjrip.mongodb.net/?retryWrites=true&w=majority

//mongoimport --uri mongodb+srv://Ashli-Vaccaro:HaHBK7bErWA8AXyX@ashli-cluster.dlfjrip.mongodb.net/myFlixDB --collection users --type json --file "C:\Users\ashli\userscollection.json"
//"mongodb+srv://Ashli-Vaccaro:HaHBK7bErWA8AXyX@ashli-cluster.dlfjrip.mongodb.net/myFlixDB?retryWrites=true&w=majority"