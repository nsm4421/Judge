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
  Future<Either<AbsError, Iterable<FetchCommentWithUser>>>
  fetchCommentByAgendaId({
    required String agendaId,
    String? parentId,
    String? beforeAt,
    int limit = 20,
  }) async => await wrap<Iterable<FetchCommentWithUser>>(() async {
    var builder = _queryBuilder
        .select("*, creator:app_users(*)")
        .eq("agenda_id", agendaId);
    if (beforeAt != null) {
      builder = builder.lt("created_at", beforeAt);
    }
    if (parentId != null) {
      builder = builder.eq("parent_id", parentId);
    }
    return await builder
        .order("created_at", ascending: false)
        .limit(limit)
        .then((res) => res.map(FetchCommentWithUser.fromJson));
  });
}
