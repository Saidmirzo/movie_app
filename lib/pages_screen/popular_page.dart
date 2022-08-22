import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/domain/blocs/poular_bloc/bloc/popular_bloc.dart';
import 'package:move_app/domain/models/movie_model.dart';
import 'package:move_app/domain/widgets/widgets.dart';
import '../domain/utils/const.dart';
import 'movie_about_pages/movie_details_page.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularBloc>().loadPopularList();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<PopularBloc, PopularState>(
        builder: (context, state) {
          if (state is PopularStateLoadList) {
            List<MovieModel> listPopular = state.listPopular;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: const Color(0xffF9F9F9),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<PopularBloc>().loadPopularList();
                },
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  children: List.generate(listPopular.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                              listPopular[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(listPopular[index].posterPath != null
                                ? 'https://image.tmdb.org/t/p/w500/${listPopular[index].posterPath}'
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
                              listPopular[index].originalTitle!,
                              style: sTextStyle(color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          } else if (state is PopularStateFailed) {
            return ConnectionErrorPage(2);
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      );
    });
  }
}
