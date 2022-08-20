import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:move_app/domain/models/video_model.dart';
import 'package:move_app/domain/providers/main_provider.dart';
import 'package:move_app/domain/utils/const.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';

class PlayVideoFromYoutube extends StatefulWidget {
  bool isLoad = false;
  int _id;
  PlayVideoFromYoutube(this._id, {Key? key}) : super(key: key);

  @override
  State<PlayVideoFromYoutube> createState() => _PlayVideoFromVimeoIdState();
}

class _PlayVideoFromVimeoIdState extends State<PlayVideoFromYoutube> {
  getList() async {
    await context.read<MainProvider>().getVideos(widget._id).then((value) {
      setState(() {
        widget.isLoad = true;
      });
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, provider, child) {
      return widget.isLoad
          ? Scaffold(
              appBar: AppBar(title: const Text('Youtube player')),
              body: SafeArea(
                child: Center(
                  child: ListView.builder(
                      itemCount: provider.listVideo.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  provider.listVideo[index].name!,
                                  style: sTextStyle(color: Colors.black, size: 18),
                                ),
                              ),
                              YoutubeVideoViewer("https://www.youtube.com/watch?v=${provider.listVideo[index].key}"),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
    });
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
      setState(() => isLoading = false);
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: urls!),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          videoQualityPriority: [360],
        ),
      )..initialise();
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
