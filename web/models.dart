library movie.models;

import 'package:polymer/polymer.dart';

class Movie {
  
  @reflectable int id;
  @reflectable String title;
  @reflectable String posterPath;
  @reflectable String releasedDate;
  @reflectable int voteAverage;
  @reflectable int voteCount;
  @reflectable bool favorite;
  @reflectable String tag;
  
  Movie.sample() {
    id = 123456;
    title = "Buffy";
    posterPath = "../common/json/images/posters/plRYSuq4fkPojnkaWUXBbHAZi1i.jpg";
    releasedDate = "1982-08-02";
    voteAverage = 9;
    voteCount = 10;
    tag = "ape planet science fiction";
  }
  
  Movie.fromJSON(Map<String, Object> json){
    id = json['id'];
    title = json['title'];
    posterPath = json['poster_path'] != null ? "../common/json/images/posters${json['poster_path']}" : "../common/img/no-poster-w130.jpg";
    releasedDate = json['release_date'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    tag = json['tag'];
  }
}