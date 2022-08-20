import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:move_app/domain/providers/main_provider.dart';
import 'package:move_app/pages_screen/movie_about_page.dart';
import 'package:move_app/pages_screen/video_page.dart';
import 'package:provider/provider.dart';

import '../domain/utils/const.dart';
import 'movie_about_pages/movie_details_page.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  ScrollController controllerScroll = ScrollController();
  @override
  void initState() {
    super.initState();

    controllerScroll.addListener(() {
      if (controllerScroll.hasClients) {
        if (controllerScroll.position.minScrollExtent ==
            controllerScroll.offset) {
          context.read<MainProvider>().setIsLoad('loadNow', false);
          context.read<MainProvider>().getNowPlayedMovies();
        }
      }
    });
    context.read<MainProvider>().getNowPlayedMovies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<MainProvider>(builder: (context, provider, child) {
      return Builder(builder: (context) {
        if (provider.isLoad['loadNow'] ?? false) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: const Color(0xffF9F9F9),
            child: 
            GridView.builder(
            controller: controllerScroll,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: provider.listNowPlayedMovies.length,
            itemBuilder: ( context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsPage(provider.listNowPlayedMovies[index],),
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(provider.listNowPlayedMovies[index].posterPath!=null? 'https://image.tmdb.org/t/p/w500/${provider.listNowPlayedMovies[index].posterPath}':'https://i.ibb.co/RPKnckW/ic-launcher-movies.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: const Color.fromRGBO(0, 0, 0, 0.6),
                      child: Center(
                        child: Text(
                          provider.listNowPlayedMovies[index].originalTitle!,
                          style: sTextStyle(color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ),
                );
            }),
           
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        }
      });
    });
  }
}
