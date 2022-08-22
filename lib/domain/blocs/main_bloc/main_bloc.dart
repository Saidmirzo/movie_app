import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainBloc extends Cubit<MainState> {
  MainBloc() : super(MainState(0));
  void changeIndexPage(int indexPage) {
    emit(MainState(indexPage));
  }
}
