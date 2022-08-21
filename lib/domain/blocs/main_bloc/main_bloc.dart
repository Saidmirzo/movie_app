import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(0)) {
    on<MainEvent>((event, emit) {});
    on<MainEventChangeIndexPage>(
      (event, emit) {
        emit(MainState(event.indexPage));
      },
    );
  }
}
