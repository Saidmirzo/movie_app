part of 'movie_about_bloc.dart';

abstract class MovieAboutState extends Equatable {
  const MovieAboutState();
}

class MovieAboutInitial extends MovieAboutState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MovieAboutStateProgress extends MovieAboutState {
  const MovieAboutStateProgress();
  @override
  List<Object?> get props => [];
}

class MovieAboutStateLoaded extends MovieAboutState {
  AboutMovieModel infoMoviAbout;
  MovieAboutStateLoaded(this.infoMoviAbout);
  @override
  List<Object?> get props => [infoMoviAbout];
}

class MovieAboutStateFailed extends MovieAboutState {
  String message;
  MovieAboutStateFailed(this.message);
  @override
  List<Object?> get props => [message];
}
