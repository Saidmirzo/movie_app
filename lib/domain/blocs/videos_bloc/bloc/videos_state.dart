part of 'videos_bloc.dart';

abstract class VideosState extends Equatable {
  const VideosState();
}

class VideosInitial extends VideosState {
  @override
  List<Object> get props => [];
}

class VideosStateInProgress extends VideosState {
  const VideosStateInProgress();
  @override
  List<Object?> get props => [];
}

class VideosStateLoadedInfo extends VideosState {
  List<VideoModel> listVideos;
  VideosStateLoadedInfo(this.listVideos);
  @override
  List<Object?> get props => [listVideos];
}

class VideosStateFailed extends VideosState {
  String message;
  VideosStateFailed(this.message);
  @override
  List<Object?> get props => [message];
}
