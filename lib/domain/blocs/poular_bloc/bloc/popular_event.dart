part of 'popular_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

  
}
class PopularEventLoadList extends PopularEvent{
  @override
  List<Object> get props => [];
}
class PopularEventSortList extends PopularEvent {
  String type;
  PopularEventSortList(this.type);
  @override
  List<Object?> get props => [type];
}
class PopularEventSearchList extends PopularEvent {
  String text;
  PopularEventSearchList(this.text);
  @override
  List<Object?> get props => [];
}
