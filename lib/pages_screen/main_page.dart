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

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  PageController controllerPage = PageController();

  late Animation<double> animation;
  late AnimationController animController;
  bool isForward = false;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    final curventAnim = CurvedAnimation(parent: animController, curve: Curves.easeOutExpo);
    animation = Tween<double>(begin: 0, end: 150).animate(curventAnim)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        sendSortFunctions(String type) {
          switch (state.indexPage) {
            case 0:
              context.read<NowPlayingBloc>().sortListNowPlaying(type);
              break;
            case 1:
              context.read<UpcommingBloc>().sortListUpcomming(type);
              break;
            case 2:
              context.read<PopularBloc>().sortListPopular(type);
              break;
            default:
          }
        }

        sendSearchFunctions(String text) {
          switch (state.indexPage) {
            case 0:
              context.read<NowPlayingBloc>().search(text);
              break;
            case 1:
              context.read<UpcommingBloc>().search(text);
              break;
            case 2:
              context.read<PopularBloc>().search(text);
              break;
            default:
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Movies',
                style: sTextStyle(color: Colors.white, size: 22),
              ),
            ),
            actions: [
              Container(
                width: 220,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: animation.value,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      child: TextField(
                        style: sTextStyle(color: Colors.white, size: 18),
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
                    Container(
                      decoration: BoxDecoration(
                        color: animation.value > 1 ? Colors.black : Colors.transparent,
                        borderRadius: animation.value > 1
                            ? const BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                topRight: Radius.circular(50),
                              )
                            : BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (isForward) {
                            animController.reverse();
                            isForward = !isForward;
                          } else {
                            animController.forward();
                            isForward = !isForward;
                          }
                        },
                        icon: const Icon(Icons.search),
                      ),
                    )
                  ],
                ),
              ),
            ],
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
              context.read<MainBloc>().changeIndexPage(index);
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
              context.read<MainBloc>().changeIndexPage(index);
            },
          ),
        );
      },
    );
  }
}
