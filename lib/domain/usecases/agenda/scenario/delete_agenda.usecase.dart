import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class DeleteAgendaUseCase {
  final AgendaRepository _repository;

  DeleteAgendaUseCase(this._repository);

  Future<Either<AbsError, String>> call(String id) async {
    return await _repository.delete(id);
    ;
  }
}
