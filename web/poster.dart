library movie.poster;

import 'package:polymer/polymer.dart';
import 'models.dart';
import 'dart:html';

@CustomTag('movie-poster')
class Poster extends PolymerElement {
  
  @published Movie movie = new Movie.sample();
  
  Poster.created() : super.created();
  
  bool get applyAuthorStyles => true;

  asStar(int nb) => new List<String>.generate(nb, (_) => "\u2605").join();

  complementTo(int comp) => (nb) => comp - nb;
 
  flipFavorite(Event e, var detail, Element target) => 
      dispatchEvent(new CustomEvent("movieupdated", detail: movie ..favorite = !movie.favorite));
  
  asFavoriteClass(bool b) => b ? "favorite-selected" : "favorite";
}