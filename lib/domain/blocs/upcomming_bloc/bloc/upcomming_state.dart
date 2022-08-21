part of 'upcomming_bloc.dart';

abstract class UpcommingState extends Equatable {
  const UpcommingState();
}

class UpcommingInitial extends UpcommingState {
  @override
  List<Object> get props => [];
}

class UpcommingStateInProgress extends UpcommingState {
  @override
  List<Object> get props => [];
}

class UpcommingStateLoadedList extends UpcommingState {
  List<MovieModel> listUpcomming;
  UpcommingStateLoadedList(this.listUpcomming);
  @override
  List<Object> get props => [listUpcomming];
}

class UpcommingStateFailed extends UpcommingState {
  String message;
  UpcommingStateFailed(this.message);
  @override
  List<Object> get props => [message];
}
