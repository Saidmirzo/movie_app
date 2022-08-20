part of 'main_bloc.dart';

@immutable
abstract class MainState extends Equatable {
  
}

 class MainInitial extends MainState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class MainStateLoadNowPlaying extends MainState{
  MainStateLoadNowPlaying();
  @override
  List<Object?> get props => [];

}