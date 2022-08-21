import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/domain/blocs/main_bloc/main_bloc.dart';
import 'package:move_app/domain/blocs/now_playing/now_playing_bloc.dart';
import 'package:move_app/domain/blocs/poular_bloc/bloc/popular_bloc.dart';
import 'package:move_app/domain/blocs/upcomming_bloc/bloc/upcomming_bloc.dart';
import '../domain/utils/const.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  PageController controllerPage = PageController();
   bool connected=false;
  checkInterne()async{
  }
  @override
  void initState() {
    super.initState();
    checkInterne();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        sendSortFunctions(String type) {
          switch (state.indexPage) {
            case 0:
              context.read<NowPlayingBloc>().add(NowPlayingEventSortList(type));
              break;
            case 1:
              context.read<UpcommingBloc>().add(UpcommingEventSortList(type));
              break;
            case 2:
              context.read<PopularBloc>().add(PopularEventSortList(type));
              break;
            default:
          }
        }

        sendSearchFunctions(String text) {
          switch (state.indexPage) {
            case 0:
              context.read<NowPlayingBloc>().add(NowPlayingEventSearchList(text));
              break;
            case 1:
              context.read<UpcommingBloc>().add(UpcommingEventSearchList(text));
              break;
            case 2:
              context.read<PopularBloc>().add(PopularEventSearchList(text));
              break;
            default:
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: sTextStyle(color: Colors.white, size: 18),
              ),
              controller: controller,
              onChanged: (text) {
                sendSearchFunctions(text);
              },
            ),
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
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
                    sendSortFunctions('name');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(
                    'Sort by date',
                    style: sTextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    sendSortFunctions('date');
                    context.read<NowPlayingBloc>().add(NowPlayingEventSortList('date'));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: Text(
                    'Sort by popular',
                    style: sTextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    sendSortFunctions('popular');
                  },
                )
              ],
            ),
          ),
          body: PageView(
            controller: controllerPage,
            onPageChanged: ((index) {
              context.read<MainBloc>().add(MainEventChangeIndexPage(index));
            }),
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.white,
            backgroundColor: Colors.blue,
            currentIndex: state.indexPage, //provider.indexPage,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chair_rounded,
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
            onTap: (index) {
              controllerPage.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
              context.read<MainBloc>().add(MainEventChangeIndexPage(index));
            },
          ),
        );
      },
    );
  }
}
