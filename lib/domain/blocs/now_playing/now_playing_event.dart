part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();
}

class NowPlayingEventLoadList extends NowPlayingEvent {
  const NowPlayingEventLoadList();
  @override
  List<Object?> get props => [];
}

class NowPlayingEventSortList extends NowPlayingEvent {
  String type;
  NowPlayingEventSortList(this.type);
  @override
  List<Object?> get props => [type];
}

class NowPlayingEventSearchList extends NowPlayingEvent {
  String text;
  NowPlayingEventSearchList(this.text);
  @override
  List<Object?> get props => [];
}
