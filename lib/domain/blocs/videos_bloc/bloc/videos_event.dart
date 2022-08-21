part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();
}

class VideosEventLoadInfo extends VideosEvent {
  int id;
  VideosEventLoadInfo(this.id);
  @override
  List<Object?> get props => [id];
}
class VideosEventsEditState extends VideosEvent{
  @override
  List<Object?> get props => [];

}
