part of 'create_agenda.cubit.dart';

@CopyWith()
class CreateAgendaState extends AbsBlocState {
  final String title;
  final List<String> options;

  CreateAgendaState({
    super.status,
    super.message,
    this.title = '',
    required this.options,
  });
}
