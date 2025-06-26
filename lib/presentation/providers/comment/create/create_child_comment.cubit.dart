import 'package:injectable/injectable.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/usecases/export.dart';
import 'package:judge/shared/export.dart';

import 'create_comment.state.dart';
import 'create_parent_comment.cubit.dart';

@injectable
class CreateChildCommentCubit extends CreateParentCommentCubit {
  final Comment _parentComment;
  final CommentUseCase _useCase;

  CreateChildCommentCubit(
    @factoryParam this._parentComment, {
    required CommentUseCase useCase,
  }) : _useCase = useCase,
       super(_parentComment.agendaId, useCase: useCase);

  @override
  Future<void> submit() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _useCase
          .create(
            agendaId: _parentComment.agendaId,
            parentId: _parentComment.id,
            content: state.content,
          )
          .then(
            (res) => res.fold(
              (l) {
                emit(state.copyWith(status: Status.error, message: l.message));
              },
              (r) {
                emit(state.copyWith(status: Status.success, message: ''));
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'un expected error'));
    }
  }
}
