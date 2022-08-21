import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/domain/blocs/movie_about_bloc/bloc/movie_about_bloc.dart';
import 'package:move_app/domain/blocs/poular_bloc/bloc/popular_bloc.dart';
import 'package:move_app/domain/blocs/upcomming_bloc/bloc/upcomming_bloc.dart';
import 'package:move_app/domain/blocs/videos_bloc/bloc/videos_bloc.dart';
import 'package:move_app/pages_screen/main_page.dart';

import 'domain/blocs/main_bloc/main_bloc.dart';
import 'domain/blocs/now_playing/now_playing_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingBloc>(create: (context)=> NowPlayingBloc()),
        BlocProvider<MainBloc>(create: (context)=> MainBloc()),
        BlocProvider<PopularBloc>(create: (context)=> PopularBloc()),
        BlocProvider<UpcommingBloc>(create: (context)=> UpcommingBloc()),
        BlocProvider<MovieAboutBloc>(create: (context)=> MovieAboutBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
