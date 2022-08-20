import 'package:flutter/material.dart';
import 'package:move_app/domain/models/about_movie_model.dart';
import 'package:move_app/domain/utils/const.dart';
import 'package:move_app/pages_screen/video_page.dart';

import 'arc_bannerImage.dart';
import 'poster.dart';
import 'rating_information.dart';

class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.movies);

  final AboutMovieModel movies;

  _buildCategoryChips(TextTheme textTheme) {
    //var genres = movies.genres;
    return (movies.genres??[]).map((genres) {
      return Chip(
        label: Text(genres.name!),
        labelStyle: textTheme.caption,
        backgroundColor: Colors.black12,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            movies.originalTitle!,
            style: sTextStyle(color: Colors.black, size: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RatingInformation(movies),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            direction: Axis.horizontal,
            children: _buildCategoryChips(textTheme),
          ),
        )
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 240.0),
          child: ArcBannerImage(movies.backdropPath!=null?
              "https://image.tmdb.org/t/p/w500/${movies.backdropPath}":'https://i.ibb.co/RPKnckW/ic-launcher-movies.png'),
        ),
        Positioned(
          bottom: 32.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: InkWell(
                  onTap: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  PlayVideoFromYoutube(movies.id!),
                      ),
                    );
                  },
                  child: Poster(movies.posterPath!=null?
                    "https://image.tmdb.org/t/p/w500/${movies.posterPath}":'https://i.ibb.co/RPKnckW/ic-launcher-movies.png',
                    height: 190.0,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: movieInformation,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
