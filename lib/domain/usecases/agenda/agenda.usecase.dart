import 'package:injectable/injectable.dart';
import 'package:judge/domain/repositories/export.dart';
import 'scenario/create_agenda.usecase.dart';
import 'scenario/fetch_agendas_with_page.usecase.dart';
import 'scenario/get_agenda_by_id.usecase.dart';
import 'scenario/update_agenda.usecase.dart';
import 'scenario/delete_agenda.usecase.dart';

@lazySingleton
class AgendaUseCase {
  final AgendaRepository _repository;

  AgendaUseCase(this._repository);

  CreateAgendaUseCase get create => CreateAgendaUseCase(_repository);

  UpdateAgendaUseCase get update => UpdateAgendaUseCase(_repository);

  DeleteAgendaUseCase get delete => DeleteAgendaUseCase(_repository);

  GetAgendaByIdUseCase get findById => GetAgendaByIdUseCase(_repository);

  FetchAgendasUseCase get fetch => FetchAgendasUseCase(_repository);
}
