part of 'display_agendas.bloc.dart';

abstract class DisplayAgendasEvent {}

class UpdateDisplayAgendasStatusEvent extends DisplayAgendasEvent {
  final Status? status;
  final String? message;

  UpdateDisplayAgendasStatusEvent({this.status, this.message});
}

class DisplayAgendasMountedEvent extends DisplayAgendasEvent {
  final int limit;

  DisplayAgendasMountedEvent({this.limit = 20});
}

class FetchMoreAgendasEvent extends DisplayAgendasEvent {
  final int limit;

  FetchMoreAgendasEvent({this.limit = 20});
}
