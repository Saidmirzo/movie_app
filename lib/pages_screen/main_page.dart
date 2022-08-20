import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:move_app/pages_screen/now_playing_page.dart';
import 'package:move_app/pages_screen/popular_page.dart';
import 'package:move_app/pages_screen/upcomming_page.dart';
import 'package:provider/provider.dart';

import '../domain/providers/main_provider.dart';
import '../domain/utils/const.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, provider, child) {
      return Scaffold(
          appBar: AppBar(
              title: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: sTextStyle(color: Colors.white, size: 18),
            ),
            controller: controller,
            onChanged: (text) {
              provider.search(text);
            },
          )),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    leading: const Icon(Icons.sort_by_alpha),
                    title: Text(
                      'Sort by name',
                      style: sTextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      provider.sort('name');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: Text(
                      'Sort by date',
                      style: sTextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      provider.sort('date');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text(
                      'Sort by population',
                      style: sTextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      provider.sort('popular');
                    },
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.white,
            backgroundColor: Colors.blue,
            currentIndex: provider.indexPage,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.domain_verification_rounded,
                  //color: Colors.grey,
                ),
                label: 'Now Playing',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_today,
                    //color: Colors.grey,
                  ),
                  label: 'Upcomming'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    //color: Colors.grey,
                  ),
                  label: 'Popular'),
            ],
            onTap: (context) {
              provider.setIndexPage(context);
            },
          ),
          body: PageView(
            children: const [NowPlayingPage(), ]//UpcommingPage(), PopularPage(), NowPlayingPage()],
          ),);
    });
  }
}
