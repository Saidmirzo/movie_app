part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();
}

class NowPlayingInitial extends NowPlayingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class NowPlayingStateProgress extends NowPlayingState{
  @override
  List<Object?> get props => [];

}
class NowPlayingStateLoadedNowPlayingList extends NowPlayingState {
  List<MovieModel> listNowPlaying;
  NowPlayingStateLoadedNowPlayingList(this.listNowPlaying);
  @override
  List<Object?> get props => [listNowPlaying];
}

class NowPlayingStateFailed extends NowPlayingState {
  String message;
  NowPlayingStateFailed(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
