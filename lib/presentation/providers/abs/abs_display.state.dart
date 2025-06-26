part of 'abs_display.bloc.dart';

@CopyWith(copyWithNull: true)
class AbsDisplayState<T> extends AbsBlocState {
  final List<T> data;
  final DateTime? cursor;
  final bool isMounted;

  AbsDisplayState({
    super.status,
    super.message,
    required this.data,
    this.cursor,
    this.isMounted = false,
  });

  bool get isEnd => cursor == null;
}
