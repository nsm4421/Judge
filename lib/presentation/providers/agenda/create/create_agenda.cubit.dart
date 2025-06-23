import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/usecases/export.dart';
import 'package:judge/shared/export.dart';

import '../../abs/abs_bloc_state.dart';

part 'create_agenda.state.dart';

part 'create_agenda.cubit.g.dart';

@injectable
class CreateAgendaCubit extends Cubit<CreateAgendaState>
    with SingletonLoggerMixIn {
  CreateAgendaCubit(this._useCase) : super(CreateAgendaState(choices: []));

  final AgendaUseCase _useCase;

  static const _maxChoiceCount = 5;

  Future<void> updateStatus({Status? status, String? message}) async {
    emit(
      state.copyWith(
        status: status ?? state.status,
        message: message ?? state.message,
      ),
    );
  }

  Future<void> updateTitle(String title) async {
    emit(state.copyWith(title: title));
  }

  Future<void> addChoice(String text) async {
    if (state.choices.length >= _maxChoiceCount) return;
    emit(state.copyWith(choices: [...state.choices, text]));
  }

  Future<void> removeChoice(int index) async {
    if (state.choices.length < 2) return;
    final temp = [...state.choices];
    temp.removeAt(index);
    emit(state.copyWith(choices: temp));
  }

  Future<void> updateChoice({
    required int index,
    required String choice,
  }) async {
    final temp = [...state.choices];
    temp[index] = choice;
    emit(state.copyWith(choices: temp));
  }

  Future<void> submit() async {
    try {
      await _useCase
          .create(title: state.title, choices: state.choices)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
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
