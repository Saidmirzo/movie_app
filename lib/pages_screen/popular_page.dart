import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:move_app/domain/providers/main_provider.dart';
import 'package:move_app/pages_screen/movie_about_page.dart';
import 'package:provider/provider.dart';

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
    context.read<MainProvider>().getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<MainProvider>(builder: (context, provider, child) {
     // provider.setIsLoad('loadAbout', false);

      return Builder(builder: (context) {
        if (provider.isLoad['loadPopular'] ?? false) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: const Color(0xffF9F9F9),
            child: GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              children:
                  List.generate(provider.listPopulardMovies.length, (index) {
                // var list = context.watch<MainProvider>().listGallery;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsPage(
                          provider.listPopulardMovies[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                    
                      image: DecorationImage(
                        image: NetworkImage(provider.listPopulardMovies[index].posterPath!=null? 'https://image.tmdb.org/t/p/w500/${provider.listPopulardMovies[index].posterPath}':'https://i.ibb.co/RPKnckW/ic-launcher-movies.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: const Color.fromRGBO(0, 0, 0, 0.6),
                      child: Center(
                        child: Text(
                          provider.listPopulardMovies[index].originalTitle!,
                          style: sTextStyle(color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ),);
        }
      });
    });
  }
}
