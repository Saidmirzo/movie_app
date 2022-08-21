part of 'main_bloc.dart';

@immutable
abstract class MainEvent extends Equatable {
  const MainEvent();
}

class MainEventChangeIndexPage extends MainEvent {
  int indexPage;
  MainEventChangeIndexPage(this.indexPage);
  @override
  List<Object?> get props => [num];
}

