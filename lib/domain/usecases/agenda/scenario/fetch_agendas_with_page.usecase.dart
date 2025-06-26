import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class FetchAgendasUseCase {
  final AgendaRepository _repository;

  FetchAgendasUseCase(this._repository);

  Future<Either<AbsError, Pageable<Agenda>>> call({
    DateTime? beforeAt,
    int limit = 20,
  }) async {
    return await _repository.fetchWithPage(
      beforeAt: (beforeAt ?? DateTime.now()).toIso8601String(),
      limit: limit,
    );
  }
}
