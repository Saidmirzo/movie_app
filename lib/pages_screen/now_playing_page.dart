import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/domain/models/movie_model.dart';
import 'package:move_app/domain/widgets/widgets.dart';

import '../domain/blocs/now_playing/now_playing_bloc.dart';
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
    context.read<NowPlayingBloc>().add(const NowPlayingEventLoadList());
  }

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
      builder: (context, state) {
        if (state is NowPlayingStateLoadedNowPlayingList) {
          List<MovieModel> listNowPlaying = state.listNowPlaying;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: const Color(0xffF9F9F9),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<NowPlayingBloc>().add(const NowPlayingEventLoadList());
              },
              child: GridView.builder(
                  controller: controllerScroll,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: listNowPlaying.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                              listNowPlaying[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 200,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(listNowPlaying[index].posterPath != null
                                ? 'https://image.tmdb.org/t/p/w500/${listNowPlaying[index].posterPath}'
                                : 'https://i.ibb.co/RPKnckW/ic-launcher-movies.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: const Color.fromRGBO(0, 0, 0, 0.6),
                          child: Center(
                            child: Text(
                              listNowPlaying[index].originalTitle!,
                              style: sTextStyle(color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        } else if (state is NowPlayingStateFailed) {
          return   ConnectionErrorPage(0);
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        }
      },
    );
  }
}
