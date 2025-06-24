import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class EditChoiceUseCase {
  final ChoiceRepository _repository;

  EditChoiceUseCase(this._repository);

  Future<Either<AbsError, void>> call({
    required String agendaId,
    int? selected,
  }) async {
    return selected == null
        ? await _repository.deleteByAgendaId(agendaId)
        : await _repository.upsert(agendaId: agendaId, selected: selected);
  }
}
