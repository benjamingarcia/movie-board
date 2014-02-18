library movie.posters;

import 'package:polymer/polymer.dart';
import 'models.dart';
import 'services.dart';
import 'utils.dart';
import 'dart:html';
import 'dart:async';

const ms = const Duration(milliseconds: 400);

@CustomTag('movie-posters')
class Posters extends PolymerElement {
  
  @observable List<Movie> movies;
  
  @observable String searchTerm = '';
  
  @observable String sortField = 'default';
  
  @observable bool sortAscending = true;
  
  @observable String searchFilter = '';
  
  @observable bool favMenu = false;
  
  bool get applyAuthorStyles => true;
  
  Posters.created() : super.created() {
    moviesService.getAllMovies().then((List ms) => movies = ms);
  }
  
  filter(String searchTerm){
    return (List<Movie> m) =>  searchTerm.isNotEmpty ? m.where((Movie m) => m.title.toLowerCase().contains(searchTerm.toLowerCase())) : m;
  }
  
  sort(Event e, var detail, Element target){
    var field = target.dataset['field'];
    sortAscending = field == sortField ? !sortAscending : true;
    sortField =field;
    applySelected(target, "gb");
  }
  
  sortBy(String field, bool asc) => (Iterable<Movie> ms){
    List result = ms.toList()..sort(Movie.getComparator(field));
    return asc ? result : result.reversed;
  };
  
  Timer timer;
  searchTermChanged(String oldValue) {
    if (timer != null && timer.isActive) timer.cancel();
    timer = new Timer(ms, () => searchFilter = searchTerm);
  }
  
  showCategory(Event e, var detail, Element target) {
    applySelected(target, 'item');
    switch (target.id) {
      case "all": moviesService.getAllMovies().then((List<Movie> ms) => movies = ms); favMenu = true; break;
      case "playing": moviesService.getMovies("now_playing").then((List<Movie> ms) => movies = ms); favMenu = true; break;
      case "upcoming": moviesService.getMovies("upcoming").then((List<Movie> ms) => movies = ms); favMenu = true; break;
      case "favorite": 
        moviesService.getFavorites().then((List<Movie> ms) => movies = ms); 
        favMenu = true;
        break;
    }
  }
  
  movieUpdated(Event e, Movie detail, Element target) {
    if (favMenu && !detail.favorite) movies = movies.where((Movie m) => m != detail).toList();
  }
}