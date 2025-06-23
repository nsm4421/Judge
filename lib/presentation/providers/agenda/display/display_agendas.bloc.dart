import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/usecases/export.dart';
import 'package:judge/shared/export.dart';
import '../../abs/abs_bloc_state.dart';

part 'display_agendas.state.dart';

part 'display_agendas.event.dart';

part 'display_agendas.bloc.g.dart';

@injectable
class DisplayAgendasBloc extends Bloc<DisplayAgendasEvent, DisplayAgendasState>
    with SingletonLoggerMixIn {
  final AgendaUseCase _useCase;

  DisplayAgendasBloc(this._useCase)
    : super(DisplayAgendasState(data: [], cursor: DateTime.now().toUtc())) {
    on<UpdateDisplayAgendasStatusEvent>(_onUpdate);
    on<DisplayAgendasMountedEvent>(_onMount);
    on<FetchMoreAgendasEvent>(_onFetchMore);
  }

  Future<void> _onUpdate(
    UpdateDisplayAgendasStatusEvent event,
    Emitter<DisplayAgendasState> emit,
  ) async {
    emit(
      state.copyWith(
        status: event.status ?? state.status,
        message: event.message ?? state.message,
      ),
    );
  }

  Future<void> _onMount(
    DisplayAgendasMountedEvent event,
    Emitter<DisplayAgendasState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      await _useCase.onMount
          .call(limit: event.limit)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message,
                    isMounted: false,
                  ),
                );
              },
              (r) {
                emit(
                  state
                      .copyWith(
                        status: Status.success,
                        message: '',
                        data: r.data,
                        cursor: r.nextCursor,
                        isMounted: true,
                      )
                      .copyWithNull(cursor: r.nextCursor == null),
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

  Future<void> _onFetchMore(
    FetchMoreAgendasEvent event,
    Emitter<DisplayAgendasState> emit,
  ) async {
    if (state.cursor == null) {
      logger.w('reached last cursor');
      return;
    }
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.fetchMore
          .call(beforeAt: state.cursor!, limit: event.limit)
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
                        message: '',
                        data: [...state.data, ...r.data],
                        cursor: r.nextCursor,
                      )
                      .copyWithNull(cursor: r.nextCursor == null),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'un expected error'));
    }
  }
}
