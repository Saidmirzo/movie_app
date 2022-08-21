import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:move_app/domain/models/video_model.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  VideosBloc() : super(VideosInitial()) {
    on<VideosEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<VideosEventLoadInfo>(
      (event, emit) async {
        try {
          emit(const VideosStateInProgress());
          List<VideoModel> listVideos = [];
          var uri =
              "https://api.themoviedb.org/3/movie/${event.id}/videos?api_key=e2caf0429e0e758201deda52d3d196f8&language=en-US";
          Response response = await get(
            Uri.parse(uri),
          );

          if (response.statusCode == 200) {
            for (final item in jsonDecode(response.body)['results'] as List) {
              listVideos.add(VideoModel.fromJson(item));
            }
            emit(VideosStateLoadedInfo(listVideos));
          } else {}
        } on SocketException {
          emit(VideosStateFailed('Connection error'));
        } catch (e) {
          emit(VideosStateFailed(e.toString()));
        }
      },
    );
    on<VideosEventsEditState>(
      (event, emit) {
        emit(const VideosStateInProgress());
      },
    );
  }
}
