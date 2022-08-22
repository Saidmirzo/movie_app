import 'package:flutter/material.dart';
import 'package:move_app/domain/utils/const.dart';
import 'package:move_app/pages_screen/main_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double scaleValue = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration:const Duration(milliseconds: 1000), value: 1);

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ));
    });

    _controller.forward().then((f) {
      _controller.reverse();
    });
    setState(() {
      scaleValue = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: Tween(begin: 1.5, end: 3.0).animate(_controller),
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: SizedBox(
                  child:  Image.asset('assets/iconMain.png', height: 120),
                  height: 150,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text("Movies", style: sTextStyle(color: Colors.black, size: 30, fontWeight: FontWeight.bold),)
                    .animate(
                      delay: 100.ms, // this delay only happens once at the very start
                      onPlay: (controller) => controller.repeat(), // loop
                    )
                    .fadeIn(delay: 500.ms),
              ),
            )
          ],
        ),
      ),
    );
  }
}
