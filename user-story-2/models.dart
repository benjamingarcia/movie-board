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
     id = 4;
     title = "Flop in the flag...";
     posterPath = "../common/json/images/posters/2Aur1bxpCVzyTdWnGtxysInVlAT.jpg";
     releasedDate= "2024/07/23";
     voteAverage = 5;
     voteCount = 2;
     tag = "upcoming";
   }
   
   Movie.fromJSON(Map<String, Object> json) {
     id=json['id'];
     title=json['title'];
     posterPath=json['poster_path'] != null ? "../common/json/images/posters${json['poster_path']}" : "../common/img/no-poster-w130.jpg";
     releasedDate=json['release_date'];
     voteAverage=(json['vote_average'] as num).toInt();
     voteCount=json['vote_count'];
     tag=json['tag'];
   }
 }