part of 'display_agendas.bloc.dart';

@CopyWith(copyWithNull: true)
class DisplayAgendasState extends AbsBlocState {
  final List<Agenda> data;
  final DateTime? cursor;
  final bool isMounted;

  DisplayAgendasState({
    super.status,
    super.message,
    required this.data,
    required this.cursor,
    this.isMounted = false,
  });

  bool get isEnd => cursor == null;
}
