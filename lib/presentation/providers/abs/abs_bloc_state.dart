import 'package:judge/shared/export.dart';

abstract class AbsBlocState {
  final Status status;
  final String message;

  AbsBlocState({this.status = Status.initial, this.message = ''});
}
