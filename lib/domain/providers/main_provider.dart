import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:move_app/domain/models/about_movie_model.dart';
import 'package:move_app/domain/models/movie_model.dart';
import 'package:http/http.dart';
import 'package:move_app/domain/models/video_model.dart';
import 'package:move_app/domain/utils/search.dart';
import 'package:move_app/domain/utils/sort_algoritms.dart';
import 'package:move_app/main.dart';

class MainProvider extends ChangeNotifier {
  int page = 1;
  int indexPage = 0;
  setIndexPage(int num) {
    indexPage = num;
    notifyListeners();
  }

  Map<String, bool> isLoad = {
    'loadAbout': false,
    'loadNow': false,
    'loadPopular': false,
    'loadUpcomming': false,
  };

  setIsLoad(String key, bool a) {
    isLoad[key] = a;
    notifyListeners();
  }

  AboutMovieModel? aboutMovie;
  List<MovieModel> listNowPlayedMovies = [];
  List<MovieModel> listPopulardMovies = [];
  List<MovieModel> listUpcommingMovies = [];
  List<String> listPathImg = [];
  Future getMovieAbout(int id) async {
    isLoad[id.toString()] = false;
    notifyListeners();
    try {
      Response response = await get(
        //https://api.themoviedb.org/3/movie/585511/videos?api_key=e2caf0429e0e758201deda52d3d196f8&language=en-US
        Uri.parse("https://api.themoviedb.org/3/movie/$id?api_key=e2caf0429e0e758201deda52d3d196f8"),
      );

      if (response.statusCode == 200) {
        aboutMovie = AboutMovieModel.fromJson(jsonDecode(response.body));

        isLoad[id.toString()] = true;
        notifyListeners();
      } else {
        getMovieAbout(id);
      }
    } catch (e) {
      isLoad[id.toString()] = false;
      notifyListeners();
    }
  }

  List<VideoModel> listVideo = [];
  Future<List<VideoModel>> getVideos(int id) async {
    List<VideoModel> list = [];
    try {
      var uri =
          "https://api.themoviedb.org/3/movie/${id}/videos?api_key=e2caf0429e0e758201deda52d3d196f8&language=en-US";
      Response response = await get(
        Uri.parse(uri),
      );

      if (response.statusCode == 200) {
        for (final item in jsonDecode(response.body)['results'] as List) {
          list.add(VideoModel.fromJson(item));
          listVideo.add(VideoModel.fromJson(item));
        }
        notifyListeners();
        return list;
      } else {
        getVideos(id);
      }
    } catch (e) {
      getVideos(id);
    }
    return list;
  }

  Future getNowPlayedMovies() async {
    try {
      var uri = "https://api.themoviedb.org/3/movie/now_playing?api_key=e2caf0429e0e758201deda52d3d196f8&page=${page}";
      Response response = await get(
        Uri.parse(uri),
      );

      if (response.statusCode == 200) {
        listPathImg.clear();
        listNowPlayedMovies.clear();
        var results=jsonDecode(response.body)['results'] as List;
        for (final item in results) {
          listNowPlayedMovies.add(MovieModel.fromJson(item));
          listPathImg.add(MovieModel.fromJson(item).backdropPath != null
              ? 'https://image.tmdb.org/t/p/w500/${MovieModel.fromJson(item).backdropPath}'
              : 'https://i.ibb.co/RPKnckW/ic-launcher-movies.png');
        }
        isLoad['loadNow'] = true;

        notifyListeners();
        if (page < jsonDecode(response.body)['total_results'] && page < 20) {
          page++;
        } else {
          page = 1;
        }
      } else {
        getNowPlayedMovies();
      }
    } catch (e) {
      getNowPlayedMovies();
    }
  }

  Future getPopularMovies() async {
    try {
      var uri =
          "https://api.themoviedb.org/3/movie/popular?api_key=e2caf0429e0e758201deda52d3d196f8&page=${Random.secure().nextInt(150) + 1}";
      debugPrint(uri);

      Response response = await get(
        Uri.parse(uri),
      );

      if (response.statusCode == 200) {
        listPathImg.clear();
        listPopulardMovies.clear();
        for (final item in jsonDecode(response.body)['results']) {
          listPopulardMovies.add(MovieModel.fromJson(item));
          listPathImg.add('https://image.tmdb.org/t/p/w500/${MovieModel.fromJson(item).backdropPath}');
        }
        isLoad['loadPopular'] = true;
        notifyListeners();
      } else {
        getPopularMovies();
      }
    } catch (e) {
      getPopularMovies();
    }
  }

  Future getUpcomingMovies() async {
    try {
      Response response = await get(
        Uri.parse(
            "https://api.themoviedb.org/3/movie/upcoming?api_key=e2caf0429e0e758201deda52d3d196f8&page=${Random.secure().nextInt(17) + 1}"),
      );

      if (response.statusCode == 200) {
        listPathImg.clear();
        listUpcommingMovies.clear();
        for (final item in jsonDecode(response.body)['results']) {
          listUpcommingMovies.add(MovieModel.fromJson(item));
          listPathImg.add('https://image.tmdb.org/t/p/w500/${MovieModel.fromJson(item).backdropPath}');
        }
        isLoad['loadUpcomming'] = true;
        notifyListeners();
      } else {
        getUpcomingMovies();
      }
    } catch (e) {
      getUpcomingMovies();
    }
  }

//---------------------------------------------------------------
  search(String text) {
    if (indexPage == 0) {
      listNowPlayedMovies = SearchA().search(listNowPlayedMovies, text);
    } else if (indexPage == 1) {
      listUpcommingMovies = SearchA().search(listUpcommingMovies, text);
    } else {
      listPopulardMovies = SearchA().search(listPopulardMovies, text);
    }
    notifyListeners();
  }

//---------------------------------------------------------------
  sort(String type) {
    List<MovieModel> mainList = [];
    if (indexPage == 0) {
      mainList.addAll(listNowPlayedMovies);
    } else if (indexPage == 1) {
      mainList.addAll(listUpcommingMovies);
    } else {
      mainList.addAll(listPopulardMovies);
    }

    List array = [];
    switch (type.toLowerCase()) {
      case 'popular':
        for (var element in mainList) {
          array.add(element.popularity!);
        }
        break;
      case 'rate':
        for (var element in mainList) {
          array.add(element.popularity!);
        }
        break;
      case 'date':
        for (var element in mainList) {
          array.add(element.releaseDate!);
        }
        break;
      case 'name':
        for (var element in mainList) {
          array.add(element.originalTitle!);
        }
        break;

      default:
    }
    mainList = SortAlgoritm().sort(mainList, array);
    if (indexPage == 0) {
      listNowPlayedMovies = mainList;
    } else if (indexPage == 1) {
      listUpcommingMovies = mainList;
    } else {
      listPopulardMovies = mainList;
    }
    notifyListeners();
  }
}
