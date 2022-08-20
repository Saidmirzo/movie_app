import 'package:flutter/material.dart';
import 'package:move_app/domain/providers/main_provider.dart';
import 'package:move_app/pages_screen/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  ChangeNotifierProvider<MainProvider>(
      create: (_)=>MainProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
