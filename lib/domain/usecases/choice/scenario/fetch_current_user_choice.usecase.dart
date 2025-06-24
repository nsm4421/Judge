import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class FetchCurrentUserChoiceUseCase {
  final ChoiceRepository _repository;

  FetchCurrentUserChoiceUseCase(this._repository);

  Future<Either<AbsError, int?>> call(String agendaId) async {
    return await _repository.fetchSelected(agendaId);
  }
}
