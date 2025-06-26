import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/usecases/export.dart';
import '../../abs/abs_display.bloc.dart';
import 'package:judge/shared/export.dart';

@injectable
class DisplayParentCommentsBloc extends AbsDisplayBloc<Comment> {
  final String _agendaId;
  final CommentUseCase _useCase;

  DisplayParentCommentsBloc(
    @factoryParam this._agendaId, {
    required CommentUseCase useCase,
  }) : _useCase = useCase;

  @override
  Future<Either<AbsError, Pageable<Comment>>> handleFetch({
    DateTime? cursor,
    int limit = 20,
  }) async {
    return await _useCase.fetchParents(
      agendaId: _agendaId,
      beforeAt: cursor,
      limit: limit,
    );
  }
}
