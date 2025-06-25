import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/data/datasources/export.dart';
import 'repository_response_wrapper.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/data/models/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl
    with RepositoryResponseWrapperMixIn
    implements CommentRepository {
  final CommentDataSource _remoteDataSource;

  CommentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AbsError, Pageable<Comment>>> fetchCommentByAgendaId({
    required String agendaId,
    String? parentId,
    required String beforeAt,
    int limit = 20,
  }) async => await wrap<Iterable<FetchCommentWithUser>, Pageable<Comment>>(
    action: () async => await _remoteDataSource.fetchCommentByAgendaId(
      agendaId: agendaId,
      parentId: parentId,
      beforeAt: beforeAt,
      limit: limit,
    ),
    rightCallback: (e) => Pageable.from(
      data: e.map(Comment.fromModelWithUser).toList(),
      limit: limit,
    ),
  );

  @override
  Future<Either<AbsError, Comment>> createComment({
    required String agendaId,
    String? parentId,
    required String content,
  }) async => await wrap<FetchComment, Comment>(
    action: () async => await _remoteDataSource.createComment(
      CreateComment(agendaId: agendaId, parentId: parentId, content: content),
    ),
    rightCallback: (e) => Comment.fromModel(e),
  );

  @override
  Future<Either<AbsError, String>> deleteComment(String commentId) async =>
      await _remoteDataSource.deleteComment(commentId);
}
