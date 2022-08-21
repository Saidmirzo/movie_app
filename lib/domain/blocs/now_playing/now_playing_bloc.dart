import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:move_app/domain/models/movie_model.dart';

import '../../utils/search.dart';
import '../../utils/sort_algoritms.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingBloc() : super(NowPlayingInitial()) {
    List<MovieModel> listNowPlayingMovies = [];
    int page = 1;
    on<NowPlayingEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NowPlayingEventLoadList>(
      (event, emit) async {
        try {
          emit(NowPlayingStateProgress());
          List<MovieModel> listNowPlaying = [];
          var uri =
              "https://api.themoviedb.org/3/movie/now_playing?api_key=e2caf0429e0e758201deda52d3d196f8&page=${page}";
          Response response = await get(
            Uri.parse(uri),
          );

          if (response.statusCode == 200) {
            listNowPlayingMovies.clear();
            listNowPlaying.clear();
            var results = jsonDecode(response.body)['results'] as List;
            for (final item in results) {
              listNowPlaying.add(MovieModel.fromJson(item));
              listNowPlayingMovies.add(MovieModel.fromJson(item));
            }
            emit(NowPlayingStateLoadedNowPlayingList(listNowPlaying));
            if (page < jsonDecode(response.body)['total_results'] && page < 20) {
              page++;
            } else {
              page = 1;
            }
          } else {}
        } on SocketException {
          emit(NowPlayingStateFailed('Connection error'));
        } catch (e) {
          emit(NowPlayingStateFailed(e.toString()));
        }
      },
    );
    on<NowPlayingEventSortList>(
      (event, emit) {
        List<MovieModel> mainList = [...listNowPlayingMovies];

        List array = [];
        switch (event.type.toLowerCase()) {
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
        emit(NowPlayingStateLoadedNowPlayingList(mainList));
      },
    );
    on<NowPlayingEventSearchList>(
      (event, emit) {
        emit(NowPlayingStateLoadedNowPlayingList(SearchA().search(listNowPlayingMovies, event.text)));
      },
    );
  }
}
