# TheMoviesDB

This code using the follwing cocoa pods:

- Noke - for loading imges from url
- XCDYouTubeKit -  to resolve youTube video link from ID

Before first run. you must run pod install.

The application supports DARK MODE as well.

This small application is using  www.themoviedb.org API:
- get Genres -> https://api.themoviedb.org/3/genre/movie/list?api_key=XXX

- get Movies -> https://api.themoviedb.org/3/movie/popular?api_key=XXX&language=en-US&page=Y 

- get Movie Videos -> https://api.themoviedb.org/3/movie/<<movie_id>>/videos?api_key=XXX

#### Application flow:

First, it brings a genre list.

After selecting a genre, it will fetch the popular movie list and highlight the movies (light Gray Clolor) that are from the chosen genre. The selected genre will be display on the top of the screen.

When clicking a movie from the list - it will bring the movie detail. it is also possible to watch the movie traillers. to get the trailers list, click on the "trailer list" button.

Now you can choose a trailer to play.
The applecation is using native player to play them.

## Genre List

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.50.07.png)
## Movies list 
The highlighted movies are from the chosen genre

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.50.30.png)
# Movie Detailes

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.50.49.png)

# Trailer list

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.50.58.png)

# Trailler Play with native iOS player

![Image description](https://github.com/yaelbe/TheMoviesDB/blob/master/screens/Screen%20Shot%202020-04-11%20at%2021.51.11.png)
