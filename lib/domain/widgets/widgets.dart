import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/domain/blocs/now_playing/now_playing_bloc.dart';
import 'package:move_app/domain/blocs/poular_bloc/bloc/popular_bloc.dart';
import 'package:move_app/domain/blocs/upcomming_bloc/bloc/upcomming_bloc.dart';
import 'package:move_app/domain/utils/const.dart';

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ConnectionErrorPage extends StatelessWidget {
  ConnectionErrorPage(this.indexPage, {Key? key}) : super(key: key);
  int indexPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/gif4.gif'),
            Text(
              'Please check your',
              style: sTextStyle(color: Colors.black, size: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'network connection ',
              style: sTextStyle(color: Colors.black, size: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                switch (indexPage) {
                  case 0:
                    context.read<NowPlayingBloc>().add(const NowPlayingEventLoadList());
                    break;
                  case 1:
                    context.read<UpcommingBloc>().add(const UpcommingEventLoadList());
                    break;
                  case 2:
                    context.read<PopularBloc>().add(PopularEventLoadList());
                    break;
                  default:
                }
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                height: 50,
                width: 120,
                child: Text(
                  'Try again',
                  style: sTextStyle(color: Colors.white, size: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
