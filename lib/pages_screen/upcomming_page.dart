import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/domain/blocs/poular_bloc/bloc/popular_bloc.dart';
import 'package:move_app/domain/blocs/upcomming_bloc/bloc/upcomming_bloc.dart';
import 'package:move_app/domain/models/movie_model.dart';
import 'package:move_app/domain/widgets/widgets.dart';
import '../domain/utils/const.dart';
import 'movie_about_pages/movie_details_page.dart';

class UpcommingPage extends StatefulWidget {
  const UpcommingPage({Key? key}) : super(key: key);

  @override
  State<UpcommingPage> createState() => _UpcommingPageState();
}

class _UpcommingPageState extends State<UpcommingPage> {
  @override
  void initState() {
    super.initState();
    context.read<UpcommingBloc>().add(const UpcommingEventLoadList());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<UpcommingBloc, UpcommingState>(
      builder: (context, state) {
        if (state is UpcommingStateLoadedList) {
          List<MovieModel> listUpcomming = state.listUpcomming;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: const Color(0xffF9F9F9),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<UpcommingBloc>().add(const UpcommingEventLoadList());
              },
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
                crossAxisCount: 2,
                children: List.generate(listUpcomming.length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsPage(
                            listUpcomming[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(listUpcomming[index].posterPath != null
                              ? 'https://image.tmdb.org/t/p/w500/${listUpcomming[index].posterPath}'
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
                            listUpcomming[index].originalTitle!,
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
        } else if (state is UpcommingStateFailed) {
          return ConnectionErrorPage(1);
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}
