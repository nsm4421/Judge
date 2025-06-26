import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class CreateCommentUseCase {
  final CommentRepository _repository;

  CreateCommentUseCase(this._repository);

  Future<Either<AbsError, void>> call({
    required String agendaId,
    required String content,
    String? parentId,
  }) async {
    return await _repository.createComment(
      agendaId: agendaId,
      content: content,
      parentId: parentId,
    );
  }
}
