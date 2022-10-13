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
mongoose.connect('mongodb+srv://Ashli-Vaccaro:HaHBK7bErWA8AXyX@ashli-cluster.dlfjrip.mongodb.net/myFlixDB?retryWrites=true&w=majority', { useNewUrlParser: true, useUnifiedTopology: true });

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const cors = require('cors');

let allowedOrigins = ['http://localhost:8080', 'http://testsite.com', 'http://localhost:1234'];

app.use(cors({
  origin: (origin, callback) => {
    if (!origin) return callback(null, true);
    if (allowedOrigins.indexOf(origin) === -1) { // If a specific origin isn’t found on the list of allowed origins
      let message = 'The CORS policy for this application doesn’t allow access from origin ' + origin;
      return callback(new Error(message), false);
    }
    return callback(null, true);
  }
}));

const { check, validationResult } = require('express-validator');

let auth = require('./auth')(app);
const passport = require('passport');
require('./passport');

// logging with morgan (middleware)
app.use(morgan("common"));


// allows user to register
app.post('/users',
  [
    check('Username', 'Username is required').isLength({ min: 5 }),
    check('Username', 'Username contains non alpanumeric characters - not allowed.').isAlphanumeric(),
    check('Password', 'Password is required').not().isEmpty(),
    check('Email', 'Email does not appear to be valid').isEmail()
  ], (req, res) => {
    let errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(422).json({
        errors: errors.array()
      });
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
            .then((user) => { res.status(201).json(user) })
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

//get user by user name
app.get('/users/:Name', passport.authenticate('jwt', { session: false }), (req, res) => {
  console.log("params", req.params)
  Users.findOne({ Name: req.params.Username })
    .then((user) => {
      res.json(user);
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send('Error: ' + err);
    });
});


// allows users to update their info
// UPDATE
// let users = users.find(users => users.Name == Name);

app.put('/users/:Name', passport.authenticate('jwt', { session: false }), (req, res) => {
  const Name = req.params;
  const updatedUser = req.body;

  if (Users) {
    Users.name = updatedUser.name;
    res.status(200).json(Users);
  } else {
    res.status(400).send('no user found')
  }
});

app.put('/users/:Name', (req, res) => {
  Users.find({ Name: req.params.Name }, {
    $set:
    {
      Name: req.body.Name,
      Password: req.body.Password,
      Email: req.body.Email,
      Birth: req.body.Birthday
    }
  },
    { new: true }, // This line makes sure that the updated document is returned
    (err, updatedUser) => {
      if (err) {
        console.error(err);
        res.status(500).send('Error: ' + err);
      } else {
        res.json(updatedUser);
      }
    });
});

// // allows users to add a movie to their favorites
// // POST
app.post('/users/:Name/favoriteMovies/:Movie', passport.authenticate('jwt', { session: false }), (req, res) => {
  Users.find(
    { Name: req.params.Name },
    {
      push: { favoriteMovies: req.params.Movie },
    },
    { new: true },
    (err, updatedUser) => {
      if (err) {
        console.error(err);
        res.status(500).send('Error:' + err);
      }
      else {
        res.json(updatedUser);
      }
    }
  );
});

// // allows users to delete a movie
// // DELETE
app.delete('/users/:Name/favoriteMovies/:Movie', passport.authenticate('jwt', { session: false }), (req, res) => {
  Users.find({ Name: req.params.Name }, {
    pull: { favoriteMovies: req.params.Movie }
  },
    {
      if(err) {
        console.error(err);
        res.status(500).send('Error: ' + err);
      }, else() {
        res.json(updatedUser);
      },
    });
});


// // allows users to deregister
// // DELETE
app.delete('/users/:Username', passport.authenticate('jwt', { session: false }), (req, res) => {
  Users.find({ Username: req.params.Username })
    .then((user) => {
      if (!user) {
        res.status(400).send(req.params.Username + 'was not found');
      } else {
        res.status(200).send(req.params.Username + 'was deleted.');
      }
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send('Error:' + err);
    });
});


// returns list of all movies to user
// READ
app.get('/movies', (req, res) => {
  Movies.find()
    .then(function (movies) {
      res.status(201).json(movies);
    })
    .catch(function (error) {
      console.error(error);
      res.status(500).send('Error: ' + error);
    });
});

// Gets the data about a single movie by title
// READ
app.get('/movies/:title', passport.authenticate('jwt', { session: false }), (req, res) => {
  Movies.find({ Title: req.params.title }).then(movies => {
    console.log(movies);
    res.status(200).json(movies);
  });
});


// //Gets the data by genre
// // READ
app.get('/movies/genre/:genreName', passport.authenticate('jwt', { session: false }), (req, res) => {
  Movies.find({ "Genre.Name": req.params.genreName }).then(movies => {
    console.log(movies);
    res.status(200).json(movies);
  });
});

// // gets the data about the director
// // READ
app.get('/movies/director/:directorName', passport.authenticate('jwt', { session: false }), (req, res) => {
  Movies.find({ "Director.Name": req.params.directorName }).then(movies => {
    console.log(movies);
    res.status(200).json(movies);
  });
});

app.get("/documentation", (req, res) => {
  res.sendFile("public/documentation.html", { root: __dirname });
});


const port = process.env.PORT || 8080;
app.listen(port, '0.0.0.0', () => {
  console.log('Listening on Port' + port);
});




