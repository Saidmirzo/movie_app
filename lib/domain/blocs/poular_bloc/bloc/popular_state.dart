part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();
}

class PopularInitial extends PopularState {
  @override
  List<Object> get props => [];
}

class PopularStateInProgress extends PopularState {
  @override
  List<Object> get props => [];
}

class PopularStateLoadList extends PopularState {
  List<MovieModel> listPopular;
  PopularStateLoadList(this.listPopular);
  @override
  List<Object> get props => [listPopular];
}

class PopularStateFailed extends PopularState {
  String message;
  PopularStateFailed(this.message);
  @override
  List<Object> get props => [message];
}
