part of 'upcomming_bloc.dart';

abstract class UpcommingEvent extends Equatable {
  const UpcommingEvent();
}

class UpcommingEventLoadList extends UpcommingEvent {
  const UpcommingEventLoadList();
  @override
  List<Object?> get props => [];
}
class UpcommingEventSortList extends UpcommingEvent {
  String type;
  UpcommingEventSortList(this.type);
  @override
  List<Object?> get props => [type];
}
class UpcommingEventSearchList extends UpcommingEvent {
  String text;
  UpcommingEventSearchList(this.text);
  @override
  List<Object?> get props => [];
}
