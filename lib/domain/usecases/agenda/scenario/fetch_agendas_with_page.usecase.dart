import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class FetchAgendasOnMountUseCase {
  final AgendaRepository _repository;

  FetchAgendasOnMountUseCase(this._repository);

  Future<Either<AbsError, Pageable<Agenda>>> call({int limit = 20}) async {
    return await _repository.fetchWithPage(limit: limit);
  }
}

class FetchMoreAgendasUseCase {
  final AgendaRepository _repository;

  FetchMoreAgendasUseCase(this._repository);

  Future<Either<AbsError, Pageable<Agenda>>> call({
    required DateTime beforeAt,
    int limit = 20,
  }) async {
    return await _repository.fetchWithPage(
      beforeAt: beforeAt.toIso8601String(),
      limit: limit,
    );
  }
}
