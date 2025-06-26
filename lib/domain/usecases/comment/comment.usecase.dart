import 'package:injectable/injectable.dart';
import 'package:judge/domain/repositories/export.dart';
import 'scenario/fetch_comments.usecase.dart';
import 'scenario/create_comment.usecase.dart';
import 'scenario/delete_comment.usecase.dart';

@lazySingleton
class CommentUseCase {
  final CommentRepository _repository;

  CommentUseCase(this._repository);

  FetchParentCommentsUseCase get fetchParents =>
      FetchParentCommentsUseCase(_repository);

  FetchChildCommentsUseCase get fetchChildren =>
      FetchChildCommentsUseCase(_repository);

  CreateCommentUseCase get create => CreateCommentUseCase(_repository);

  DeleteCommentUseCase get delete => DeleteCommentUseCase(_repository);
}
