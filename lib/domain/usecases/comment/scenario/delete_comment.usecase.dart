import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class DeleteCommentUseCase {
  final CommentRepository _repository;

  DeleteCommentUseCase(this._repository);

  Future<Either<AbsError, void>> call(String commentId) async {
    return await _repository.deleteComment(commentId);
  }
}
