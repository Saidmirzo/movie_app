part of 'main_bloc.dart';

@immutable
class MainState extends Equatable {
  final int indexPage;
  const MainState(this.indexPage);
  @override
  List<Object?> get props => [indexPage];
}


