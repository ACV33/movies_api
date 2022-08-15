const express = require("express");
const app = express(),
    uuid = require("uuid"),
    bodyParser = require("body-parser");

app.use(bodyParser.json());

let users = [
    {
        "id": "1",
        "name": "Ashli",
        "favoriteMovies": ["The Labyrinth"]
   },
    {
        "id": "2",
        "name": "Ally",
        "favoriteMovies": ["Dirty Dancing"]
    }
]
let movies = [
  {
      "title": "Stand By Me",
      "director": {
          "name": "Rob Reiner",
          "bio": "Robert Reiner was born in New York City, to Estelle Reiner (née Lebost) and Emmy-winning actor, comedian, writer, and producer Carl Reiner. As a child, his father was his role model, as Carl Reiner created and starred in The Dick Van Dyke Show.",
          "birth-year": 1947
      },
      "description": "After the death of one of his friends, a writer recounts a childhood journey with his friends to find the body of a missing boy.",
      "genre": {
          "name": "drama",
          "description": "The drama genre features stories with high stakes and a lot of conflicts. They're plot-driven and demand that every character and scene move the story forward. Dramas follow a clearly defined narrative plot structure, portraying real-life scenarios or extreme situations with emotionally-driven characters."
      },
      "imageURL": "https://en.wikipedia.org/wiki/Stand_by_Me_%28film%29"
  },
  {
      "title": "Goodfellas",
      "director": {
          "name": "Martin Scorsese",
          "bio": "Martin Charles Scorsese was born on November 17, 1942 in Queens, New York City, to Catherine Scorsese (née Cappa) and Charles Scorsese, who both worked in Manhattan's garment district, and whose families both came from Palermo, Sicily. He was raised in the neighborhood of Little Italy, which later provided the inspiration for several of his films. Scorsese earned a B.S. degree in film communications in 1964, followed by an M.A. in the same field in 1966 at New York University's School of Film. During this time, he made numerous prize-winning short films including The Big Shave (1967), and directed his first feature film, Who's That Knocking at My Door (1967).",
          "birth-year": 1942
      },
      "description": "The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito in the Italian-American crime syndicate.",
      "genre": {
          "name": "drama",
          "description": "The drama genre features stories with high stakes and a lot of conflicts. They're plot-driven and demand that every character and scene move the story forward. Dramas follow a clearly defined narrative plot structure, portraying real-life scenarios or extreme situations with emotionally-driven characters."
      },
      "imageURL": "https://en.wikipedia.org/wiki/File:Goodfellas.jpg"
  },
  {
      "title": "Girls Just Wanna Have Fun",
      "director": {
          "name": "Alan Metter",
          "bio": "Alan began his creative life at Doyle Dane Bernbach (DDB), the legendary advertising agency. In the late 1970s, Metter leaped at the opportunity to direct some of the first music videos for the likes of George Harrison, Glenn Frey, Joe Walsh, Chicago, Olivia Newton-John, and Donna Summer, as well as comedians Rodney Dangerfield and Steve Martin, which were aired on the fledgling MTV.",
          "birth-year": 1942,
          "death-year": 2020
      },
      "description": "Janey is new in town and soon meets Lynne, who shares her passion for dancing in general and Dance TV in particular.",
      "genre": {
          "name": "romance",
          "description": "The aim of the genre is simple, showcasing a love story where two people overcome adversity to obtain their happily ever after. "
      },
      "imageURL": "https://en.wikipedia.org/wiki/File:Girls_just_want_to_have_fun.jpg"
  },
  {
      "title": "Sex and the City",
      "director": {
          "name": "Michael Patrick King",
          "bio": "Michael Patrick King was born on September 14, 1954 in Scranton, Pennsylvania, USA. He is a producer and writer, known for Sex and the City 2 (2010), Sex and the City (1998) and Sex and the City (2008).",
          "birth-year": 1954
      },
      "description": "A New York City writer on sex and love is finally getting married to her Mr. Big. But her three best girlfriends must console her after one of them inadvertently leads Mr. Big to jilt her.",
      "genre": {
          "name": "romance",
          "description": "The aim of the genre is simple, showcasing a love story where two people overcome adversity to obtain their happily ever after. "
      },
      "imageURL": "https://en.wikipedia.org/wiki/File:Sex_and_the_City_The_Movie.jpg"
  },
  {
      "title": "Edward Scissorhands",
      "director": {
          "name": "Tim Burton",
          "bio": "Timothy Walter Burton was born in Burbank, California, to Jean Rae (Erickson), who owned a cat-themed gift shop, and William Reed Burton, who worked for the Burbank Park and Recreation Department. He spent most of his childhood as a recluse, drawing cartoons, and watching old movies",
          "birth-year": 1958
      },
      "description": "An artificial man, who was incompletely constructed and has scissors for hands, leads a solitary life. Then one day, a suburban lady meets him and introduces him to her world.",
      "genre": {
          "name": "drama",
          "description": "The drama genre features stories with high stakes and a lot of conflicts. They're plot-driven and demand that every character and scene move the story forward. Dramas follow a clearly defined narrative plot structure, portraying real-life scenarios or extreme situations with emotionally-driven characters.",
      },
      "imageURL": "https://en.wikipedia.org/wiki/File:Edwardscissorhandsposter.JPG"
  },
];

// allows  new user to register
// CREATE
app.post("/users", (req, res) => {
  const newUser = req.body;

  if (newUser.name) {
    newUser.id = uuid.v4();
    users.push(newUser);
  res.status(201).json(newUser)  
} else {
  res.status(400).send('users need names')
}
});

// allows users to update their info
// UPDATE
app.put("/users/:id", (req, res) => {
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

// allows users to add a movie to their favorites
// POST
app.post("/users/:id/:movieTitle", (req, res) => {
  const { id, movieTitle } = req.params;

 let user = users.find( user => user.id == id);

if (user) {
      user.favoriteMovies.push(movieTitle);
      res.status(200).send(`${movieTitle} has been added to user ${id}'s array`);;
} else {
  res.status(400).send('no user found')
}
});

// allows users to delete a movie
// DELETE
app.delete("/users/:id/:movieTitle", (req, res) => {
  const { id, movieTitle } = req.params;

 let user = users.find( user => user.id == id);

if (user) {
      user.favoriteMovies = user.favoriteMovies.filter( title => title !== movieTitle);
      res.status(200).send(`${movieTitle} has been removed from user ${id}'s array`);;
} else {
  res.status(400).send('no user found')
}
});

// allows users to deregister
// DELETE
app.delete("/users/:id", (req, res) => {
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
app.get("/movies", (req, res) => {
    res.json(movies);
  });

  // Gets the data about a single movie by title
  // READ
app.get("/movies/:title", (req, res) => {
  res.json(movies.find((movies) =>
    { return movies.title === req.params.title }));
});

//Gets the data by genre
// READ
app.get("/movies/genre/:genreName", (req, res) => {
  const { genreName } = req.params;
  const genre = movies.find(movie => movie.genre.name === genreName).genre;

  if (genre) {
      res.status(200).json(genre);
  } else {
      res.status(400).send("genre not found")
  }
});

// gets the data about the director
// READ
app.get("/movies/director/:directorName", (req, res) => {
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


// listen for requests
app.listen(8080, () => {
  console.log("Your app is listening on port 8080.");
});

