import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:move_app/domain/models/movie_model.dart';

import '../../../utils/search.dart';
import '../../../utils/sort_algoritms.dart';

part 'upcomming_state.dart';

class UpcommingBloc extends Cubit<UpcommingState> {
  List<MovieModel> listUpcommingMocies = [];
  int page = 1;
  UpcommingBloc() : super(UpcommingInitial());
  loadListUpcomming() async {
    try {
      emit(UpcommingStateInProgress());
      List<MovieModel> listUpcomming = [];
      Response response = await get(
        Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=e2caf0429e0e758201deda52d3d196f8&page=$page"),
      );

      if (response.statusCode == 200) {
        listUpcommingMocies.clear();
        for (final item in jsonDecode(response.body)['results']) {
          listUpcomming.add(MovieModel.fromJson(item));
          listUpcommingMocies.add(MovieModel.fromJson(item));
        }
        emit(UpcommingStateLoadedList(listUpcomming));
        if (page < jsonDecode(response.body)['total_results'] && page < 15) {
          page++;
        } else {
          page = 1;
        }
      } else {}
    } on SocketException {
      emit(UpcommingStateFailed('Connection error'));
    } catch (e) {
      emit(UpcommingStateFailed(e.toString()));
    }
  }

  sortListUpcomming(String type) {
    List<MovieModel> mainList = [...listUpcommingMocies];

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
    emit(UpcommingStateLoadedList(mainList));
  }

  search(String text) {
    emit(UpcommingStateLoadedList(SearchA().search(listUpcommingMocies, text)));
  }
}
