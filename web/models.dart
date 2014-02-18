library movie.models;

import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';

class Movie {
  
  @reflectable int id;
  @reflectable String title;
  @reflectable String posterPath;
  @reflectable String releasedDate;
  @reflectable int voteAverage;
  @reflectable int voteCount;
  @reflectable bool favorite = false;
  @reflectable String tag;
  
  static final Map _comparators = {
    "default": (Movie a, Movie b) => 0,
    "title": (Movie a, Movie b) => a.title.compareTo(b.title),
    "vote": (Movie a, Movie b) => a.voteAverage.compareTo(b.voteAverage),
    "favorite": (Movie a, Movie b) => a.favorite && !b.favorite ? -1 : b.favorite && !a.favorite ? 1 : 0,
  };
  
  static getComparator(String field){
    return _comparators[field];
  }
  
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
    id=json['id'];
    title=json['title'];
    posterPath=json['poster_path'] != null ? "../common/json/images/posters${json['poster_path']}" : "../common/img/no-poster-w130.jpg";
    releasedDate=json['release_date'];
    voteAverage=(json['vote_average'] as num).toInt();
    voteCount=json['vote_count'];
    tag=json['tag'];
    
    favorite = false;
    try {
      String data = window.localStorage["${id}"];
      if (data != null) favorite = JSON.decode(data)["fav"];
    }
    catch(e) {
    }
    
    new PathObserver(this, 'favorite').changes.listen((records) {
      window.localStorage["${id}"] = '{ "fav" : ${records[0].newValue} }';
    });
  }
}