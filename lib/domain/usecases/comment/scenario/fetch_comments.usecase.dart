import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class FetchParentCommentsUseCase {
  final CommentRepository _repository;

  FetchParentCommentsUseCase(this._repository);

  Future<Either<AbsError, Pageable<Comment>>> call({
    required String agendaId,
    String? parentId,
    DateTime? beforeAt,
    int limit = 20,
  }) async {
    return await _repository.fetchParentComments(
      agendaId: agendaId,
      beforeAt: (beforeAt ?? DateTime.now()).toIso8601String(),
      limit: limit,
    );
  }
}

class FetchChildCommentsUseCase {
  final CommentRepository _repository;

  FetchChildCommentsUseCase(this._repository);

  Future<Either<AbsError, Pageable<Comment>>> call({
    required String agendaId,
    String? parentId,
    DateTime? beforeAt,
    int limit = 20,
  }) async {
    return await _repository.fetchChildComments(
      parentId: parentId,
      beforeAt: (beforeAt ?? DateTime.now()).toIso8601String(),
      limit: limit,
    );
  }
}
