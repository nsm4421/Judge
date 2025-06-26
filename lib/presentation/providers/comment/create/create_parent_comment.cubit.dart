import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/usecases/export.dart';
import 'package:judge/shared/export.dart';

import 'create_comment.state.dart';

@injectable
class CreateParentCommentCubit extends Cubit<CreateCommentState>
    with SingletonLoggerMixIn {
  CreateParentCommentCubit(
    @factoryParam this._agendaId, {
    required CommentUseCase useCase,
  }) : _useCase = useCase,
       super(CreateCommentState());
  final String _agendaId;
  final CommentUseCase _useCase;

  Future<void> updateStatus({Status? status, String? message}) async {
    emit(
      state.copyWith(
        status: status ?? state.status,
        message: message ?? state.message,
      ),
    );
  }

  Future<void> updateContent(String content) async {
    emit(state.copyWith(content: content));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _useCase
          .create(agendaId: _agendaId, content: state.content)
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
