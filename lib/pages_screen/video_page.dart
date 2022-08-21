import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/domain/blocs/videos_bloc/bloc/videos_bloc.dart';
import 'package:move_app/domain/utils/const.dart';
import 'package:pod_player/pod_player.dart';

// ignore: must_be_immutable
class PlayVideoFromYoutube extends StatefulWidget {
  final int _id;
  const PlayVideoFromYoutube(this._id, {Key? key}) : super(key: key);

  @override
  State<PlayVideoFromYoutube> createState() => _PlayVideoFromVimeoIdState();
}

class _PlayVideoFromVimeoIdState extends State<PlayVideoFromYoutube> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  //BlocProvider<VideosBloc>(create: (context)=> VideosBloc()),

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideosBloc()..add(VideosEventLoadInfo(widget._id)),
      child: BlocBuilder<VideosBloc, VideosState>(
        builder: (context, state) {
          if (state is VideosStateLoadedInfo) {
            return Scaffold(
              appBar: AppBar(title: const Text('Youtube player')),
              body: SafeArea(
                child: Center(
                  child: ListView.builder(
                      itemCount: state.listVideos.length<=4?state.listVideos.length:4,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  state.listVideos[index].name!,
                                  style: sTextStyle(color: Colors.black, size: 18),
                                ),
                              ),
                              YoutubeVideoViewer("https://www.youtube.com/watch?v=${state.listVideos[index].key}"),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}

class YoutubeVideoViewer extends StatefulWidget {
  const YoutubeVideoViewer(this.videoLink, {Key? key}) : super(key: key);
  final String videoLink;
  @override
  State<YoutubeVideoViewer> createState() => _YoutubeVideoViewerState();
}

class _YoutubeVideoViewerState extends State<YoutubeVideoViewer> {
   late final PodPlayerController controller;
  bool isLoading = true;
  bool isErrorOnLoading = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    loadVideo();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void loadVideo() async {
    
    try {
      final urls = await PodPlayerController.getYoutubeUrls(
        widget.videoLink,
      );
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: urls!),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          videoQualityPriority: [360],
        ),
      )..initialise().then((value) {
      setState(() => isLoading = false);
      });
    } catch (e) {
      isErrorOnLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CupertinoActivityIndicator(
              radius: 50,
              color: Color.fromARGB(255, 2, 5, 82),
            ),
          )
        : isErrorOnLoading
            ? Container(
                width: double.infinity,
                height: 200,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const Center(
                  child: Text("videoNotFound"),
                ),
              )
            : Center(child: PodVideoPlayer(controller: controller));
  }
}
