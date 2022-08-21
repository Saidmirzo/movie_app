part of 'movie_about_bloc.dart';

abstract class MovieAboutEvent extends Equatable {
  const MovieAboutEvent();
}

class MovieAboutEventLoad extends MovieAboutEvent {
  int id;
  MovieAboutEventLoad(this.id);
  @override
  List<Object?> get props => [id];
}
