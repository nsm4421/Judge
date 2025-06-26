import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/usecases/export.dart';
import '../../abs/abs_display.bloc.dart';
import 'package:judge/shared/export.dart';

@injectable
class DisplayChildCommentsBloc extends AbsDisplayBloc<Comment> {
  final Comment _parentComment;
  final CommentUseCase _useCase;

  DisplayChildCommentsBloc(
    @factoryParam this._parentComment, {
    required CommentUseCase useCase,
  }) : _useCase = useCase;

  Comment get parentComment => _parentComment;

  @override
  Future<Either<AbsError, Pageable<Comment>>> handleFetch({
    DateTime? cursor,
    int limit = 20,
  }) async {
    return await _useCase.fetchChildren(
      agendaId: _parentComment.agendaId,
      parentId: _parentComment.id,
      beforeAt: cursor,
      limit: limit,
    );
  }
}
