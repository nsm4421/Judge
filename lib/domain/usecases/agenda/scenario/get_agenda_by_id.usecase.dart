import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class GetAgendaByIdUseCase {
  final AgendaRepository _repository;

  GetAgendaByIdUseCase(this._repository);

  Future<Either<AbsError, Agenda>> call(String id) async {
    return await _repository.getById(id);
  }
}
