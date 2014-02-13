library movie.poster;

import 'package:polymer/polymer.dart';
import 'models.dart';

@CustomTag('movie-poster')
class Poster extends PolymerElement {
  
  @observable Movie movie = new Movie.sample();
  
  Poster.created() : super.created();
  
  bool get applyAuthorStyles => true;

  asStar(int nb) => new List<String>.generate(nb, (_) => "\u2605").join();

  complementTo(int comp) => (nb) => comp - nb;
  
}