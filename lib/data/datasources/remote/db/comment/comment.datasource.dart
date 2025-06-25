part of 'comment.datasource_impl.dart';

abstract interface class CommentDataSource {
  Future<Either<AbsError, Iterable<FetchCommentWithUser>>>
  fetchCommentByAgendaId({
    required String agendaId,
    String? parentId,
    required String beforeAt,
    int limit = 20,
  });

  Future<Either<AbsError, FetchComment>> createComment(CreateComment model);

  Future<Either<AbsError, String>> deleteComment(String commentId);
}
