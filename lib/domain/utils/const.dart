import 'package:flutter/material.dart';

import '../../pages_screen/now_playing_page.dart';
import '../../pages_screen/popular_page.dart';
import '../../pages_screen/upcomming_page.dart';

TextStyle sTextStyle(
    {Color? color, double size = 14, FontWeight fontWeight = FontWeight.w500, double? letterSpacing, double? height}) {
  return TextStyle(
      color: color ?? Colors.white,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height);
}

List<Widget> pages = const [
  NowPlayingPage(),
  UpcommingPage(),
  PopularPage(),
];
