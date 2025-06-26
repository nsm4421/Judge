import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/shared/export.dart';

abstract interface class CommentRepository {
  Future<Either<AbsError, Pageable<Comment>>> fetchParentComments({
    required String agendaId,
    required String beforeAt,
    int limit = 20,
  });

  Future<Either<AbsError, Pageable<Comment>>> fetchChildComments({
    required parentId,
    required String beforeAt,
    int limit = 20,
  });

  Future<Either<AbsError, Comment>> createComment({
    required String agendaId,
    String? parentId,
    required String content,
  });

  Future<Either<AbsError, String>> deleteComment(String commentId);
}
