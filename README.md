# TheMoviesDB

This code using the follwing cocoa pods:

- Noke - to load imges from url
- XCDYouTubeKit -  to resolve youTube video link from id

Before first run you mast run pod install.

This small applecation is using  www.themoviedb.org api:
- get Genres -> https://api.themoviedb.org/3/genre/movie/list?api_key=XXX

- get Movies -> https://api.themoviedb.org/3/movie/popular?api_key=XXX&language=en-US&page=Y 

- get Movie Videos -> https://api.themoviedb.org/3/movie/<<movie_id>>/videos?api_key=XXX

 

It bring a genre list first.

After selecting a gener it fetch the popular movie list and color the movies that fron the genre you chose.

When cliking a movie - it bring the movie details,it is also possible to watch the movie traillers.

Cliking on trailler list button will show alist of this movie.By tap on trailler name it will play it.

## Gender List

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.50.07.png)
## Movies list 
The highlighted movies are from the chosen gendre

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.50.30.png)
# Movie Detailes

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.50.49.png)

# Trailer list

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.50.58.png)

# Trailler Play with native iOS player

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.51.11.png)
