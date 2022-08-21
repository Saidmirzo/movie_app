import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:move_app/domain/models/about_movie_model.dart';

part 'movie_about_event.dart';
part 'movie_about_state.dart';

class MovieAboutBloc extends Bloc<MovieAboutEvent, MovieAboutState> {
  MovieAboutBloc() : super(MovieAboutInitial()) {
    on<MovieAboutEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<MovieAboutEventLoad>(
      (event, emit) async {
        try {
          emit(const MovieAboutStateProgress());
          AboutMovieModel infoMovieAbout;
          Response response = await get(
            //https://api.themoviedb.org/3/movie/585511/videos?api_key=e2caf0429e0e758201deda52d3d196f8&language=en-US
            Uri.parse("https://api.themoviedb.org/3/movie/${event.id}?api_key=e2caf0429e0e758201deda52d3d196f8"),
          );

          if (response.statusCode == 200) {
            infoMovieAbout = AboutMovieModel.fromJson(jsonDecode(response.body));
            emit(MovieAboutStateLoaded(infoMovieAbout));
          } else {}
        } on SocketException {
          emit(MovieAboutStateFailed('Connection error'));
        } catch (e) {
          emit(MovieAboutStateFailed(e.toString()));
        }
      },
    );
  }
}
