part of 'abs_display.bloc.dart';

abstract class AbsDisplayEvent {}

class UpdateDisplayStatusEvent extends AbsDisplayEvent {
  final Status? status;
  final String? message;

  UpdateDisplayStatusEvent({this.status, this.message});
}

class DisplayMountedEvent extends AbsDisplayEvent {
  final int limit;

  DisplayMountedEvent({this.limit = 20});
}


class DisplayFetchEvent extends AbsDisplayEvent {
  final int limit;

  DisplayFetchEvent({this.limit = 20});
}
