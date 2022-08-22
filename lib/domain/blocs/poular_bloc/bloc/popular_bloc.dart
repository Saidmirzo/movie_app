import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:move_app/domain/models/movie_model.dart';

import '../../../utils/search.dart';
import '../../../utils/sort_algoritms.dart';

part 'popular_state.dart';

class PopularBloc extends Cubit<PopularState> {
  List<MovieModel> listPopularMovies = [];
  int page = 1;
  PopularBloc() : super(PopularInitial());
  Future<void> loadPopularList() async {
    try {
      emit(PopularStateInProgress());
      List<MovieModel> listPopular = [];
      var uri = "https://api.themoviedb.org/3/movie/popular?api_key=e2caf0429e0e758201deda52d3d196f8&page=$page";

      Response response = await get(
        Uri.parse(uri),
      );

      if (response.statusCode == 200) {
        listPopularMovies.clear();
        for (final item in jsonDecode(response.body)['results']) {
          listPopular.add(MovieModel.fromJson(item));
          listPopularMovies.add(MovieModel.fromJson(item));
        }
        emit(PopularStateLoadList(listPopular));
        if (page < jsonDecode(response.body)['total_results'] && page < 20) {
          page++;
        } else {
          page = 1;
        }
      } else {}
    } on SocketException {
      emit(PopularStateFailed('Connection error'));
    } catch (e) {
      emit(PopularStateFailed(e.toString()));
    }
  }

  void sortListPopular(String type) {
    List<MovieModel> mainList = [...listPopularMovies];

    List array = [];
    switch (type.toLowerCase()) {
      case 'popular':
        for (var element in mainList) {
          array.add(element.popularity!);
        }
        break;
      case 'rate':
        for (var element in mainList) {
          array.add(element.popularity!);
        }
        break;
      case 'date':
        for (var element in mainList) {
          array.add(element.releaseDate!);
        }
        break;
      case 'name':
        for (var element in mainList) {
          array.add(element.originalTitle!);
        }
        break;

      default:
    }
    mainList = SortAlgoritm().sort(mainList, array);
    emit(PopularStateLoadList(mainList));
  }

  void search(String text) {
    emit(PopularStateLoadList(SearchA().search(listPopularMovies, text)));
  }
}
