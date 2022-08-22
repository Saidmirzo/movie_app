import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/domain/blocs/movie_about_bloc/bloc/movie_about_bloc.dart';
import 'package:move_app/domain/models/movie_model.dart';
import '../../domain/models/about_movie_model.dart';
import 'movie_detail_header.dart';
import 'production_companies_scroller.dart';
import 'story_line.dart';

// ignore: must_be_immutable
class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage(this.model, {Key? key}) : super(key: key);

  MovieModel model;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late AboutMovieModel detail;

  @override
  void initState() {
    super.initState();
    context.read<MovieAboutBloc>().loadMovieAbout(widget.model.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieAboutBloc, MovieAboutState>(
      builder: (context, state) {
        if (state is MovieAboutStateLoaded) {
          return Scaffold(
            body: SingleChildScrollView(
                    child: Column(
                      children: [
                        MovieDetailHeader(state.infoMoviAbout),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: StoryLine(state.infoMoviAbout.overview!),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 50.0,
                          ),
                          child: ProductionCompaniesScroller(state.infoMoviAbout.productionCompanies!),
                        ),
                      ],
                    ),
                  ),
          );
        } else {
          return const  Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}
