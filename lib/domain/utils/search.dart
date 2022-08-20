import 'package:move_app/domain/models/movie_model.dart';

class SearchA {
  List<MovieModel> search(List<MovieModel> list, String text) {
    List<MovieModel> natija = [];
    for (var element in list) {
      if (element.originalTitle!.toLowerCase().contains(text.toLowerCase())) {
        natija.add(element);
      }
    }
    return natija;
  }
}
