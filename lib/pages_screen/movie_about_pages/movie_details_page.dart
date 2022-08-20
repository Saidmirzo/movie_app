import 'package:flutter/material.dart';
import 'package:move_app/domain/models/movie_model.dart';
import 'package:move_app/domain/providers/main_provider.dart';
import 'package:provider/provider.dart';

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
    Future.delayed(Duration.zero,
        () => context.read<MainProvider>().getMovieAbout(widget.model.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: provider.isLoad[widget.model.id!.toString()] != true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    MovieDetailHeader(provider.aboutMovie!),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: StoryLine(provider.aboutMovie!.overview!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 50.0,
                      ),
                      child: ProductionCompaniesScroller(
                          provider.aboutMovie!.productionCompanies!),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
