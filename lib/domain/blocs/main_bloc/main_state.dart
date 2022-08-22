part of 'main_bloc.dart';


class MainState extends Equatable {
  final int indexPage;
  const MainState(this.indexPage);
  @override
  List<Object?> get props => [indexPage];
}


