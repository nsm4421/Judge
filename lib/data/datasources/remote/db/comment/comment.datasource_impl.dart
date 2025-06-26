import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:either_dart/either.dart';
import 'package:judge/data/models/export.dart';
import 'package:judge/shared/export.dart';

import '../../../remote/datasource_response_wrapper.dart';

part 'comment.datasource.dart';

class CommentDataSourceImpl
    with DataSourceResponseWrapperMixIn
    implements CommentDataSource {
  final PostgrestQueryBuilder _queryBuilder;

  CommentDataSourceImpl(this._queryBuilder);

  @override
  Future<Either<AbsError, FetchComment>> createComment(
    CreateComment model,
  ) async => await wrap<FetchComment>(() async {
    return await _queryBuilder
        .insert(model.toJson())
        .select()
        .single()
        .then(FetchComment.fromJson);
  });

  @override
  Future<Either<AbsError, String>> deleteComment(String commentId) async =>
      await wrap<String>(() async {
        return await _queryBuilder
            .delete()
            .eq("id", commentId)
            .then((_) => commentId);
      });

  @override
  Future<Either<AbsError, Iterable<FetchCommentWithUser>>> fetchParentComments({
    required String agendaId,
    required String beforeAt,
    int limit = 20,
  }) async => await wrap<Iterable<FetchCommentWithUser>>(() async {
    return await _queryBuilder
        .select("*, creator:app_users(*)")
        .eq("agenda_id", agendaId)
        .filter("parent_id", "is", null) // 부모댓글만 조회
        .lt("created_at", beforeAt)
        .order("created_at", ascending: false)
        .limit(limit)
        .then((res) => res.map(FetchCommentWithUser.fromJson));
  });

  @override
  Future<Either<AbsError, Iterable<FetchCommentWithUser>>> fetchChildComments({
    required String parentId,
    required String beforeAt,
    int limit = 20,
  }) async => await wrap<Iterable<FetchCommentWithUser>>(() async {
    return await _queryBuilder
        .select("*, creator:app_users(*)")
        .eq("parent_id", parentId)
        .lt("created_at", beforeAt)
        .order("created_at", ascending: false)
        .limit(limit)
        .then((res) => res.map(FetchCommentWithUser.fromJson));
  });
}
