import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/usecases/export.dart';
import 'package:judge/shared/export.dart';

import '../../abs/abs_bloc_state.dart';

part 'choice.state.dart';

part 'choice.cubit.g.dart';

@injectable
class ChoiceCubit extends Cubit<ChoiceState> with SingletonLoggerMixIn {
  final ChoiceUseCase _useCase;
  final Agenda _agenda;

  ChoiceCubit(@factoryParam Agenda agenda, {required ChoiceUseCase useCase})
    : _agenda = agenda.sorted,  // 추천수 순으로 정렬
      _useCase = useCase,
      super(ChoiceState());

  Agenda get agenda => _agenda;

  Future<void> mount() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _useCase
          .fetch(_agenda.id)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
                emit(
                  state.copyWith(
                    status: Status.error,
                    isMounted: false,
                    message: l.message,
                  ),
                );
              },
              (r) {
                emit(
                  state.copyWith(
                    status: Status.success,
                    isMounted: true,
                    selected: r,
                  ),
                );
              },
            ),
          );
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          isMounted: false,
          message: 'un expected error',
        ),
      );
      logger.e(error);
    }
  }

  Future<void> editOption(int? selected) async {
    if (!state.isMounted) return;
    emit(state.copyWith(status: Status.loading));
    try {
      await _useCase
          .edit(agendaId: _agenda.id, selected: selected)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
                emit(state.copyWith(status: Status.error, message: l.message));
              },
              (r) {
                emit(
                  state
                      .copyWith(
                        status: Status.success,
                        isMounted: true,
                        selected: selected,
                      )
                      .copyWithNull(selected: (selected == null)),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          isMounted: false,
          message: 'un expected error',
        ),
      );
    }
  }
}
