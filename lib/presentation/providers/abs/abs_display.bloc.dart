import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/shared/export.dart';

import 'abs_bloc_state.dart';

part 'abs_display.state.dart';

part 'abs_display.event.dart';

part 'abs_display.bloc.g.dart';

abstract class AbsDisplayBloc<T extends BaseEntity>
    extends Bloc<AbsDisplayEvent, AbsDisplayState<T>>
    with SingletonLoggerMixIn {
  AbsDisplayBloc() : super(AbsDisplayState(data: [])) {
    on<UpdateDisplayStatusEvent>(_onUpdate);
    on<DisplayMountedEvent>(_onMount);
    on<DisplayFetchEvent>(_onFetch);
  }

  Future<void> _onUpdate(
    UpdateDisplayStatusEvent event,
    Emitter<AbsDisplayState<T>> emit,
  ) async {
    emit(
      state.copyWith(
        status: event.status ?? state.status,
        message: event.message ?? state.message,
      ),
    );
  }

  Future<void> _onMount(
    DisplayMountedEvent event,
    Emitter<AbsDisplayState<T>> emit,
  ) async {
    emit(
      state.copyWith(data: [], cursor: DateTime.now(), status: Status.loading),
    );
    try {
      await handleFetch(cursor: state.cursor, limit: event.limit).then(
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
      handleError(error, emit);
    }
  }

  Future<void> _onFetch(
    DisplayFetchEvent event,
    Emitter<AbsDisplayState<T>> emit,
  ) async {
    if (state.cursor == null) {
      logger.w('cursor is not given');
      return;
    }

    emit(state.copyWith(status: Status.loading));
    try {
      await handleFetch(cursor: state.cursor, limit: event.limit).then(
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
      handleError(error, emit);
    }
  }

  /// overrrde할 함수
  Future<Either<AbsError, Pageable<T>>> handleFetch({
    DateTime? cursor,
    int limit = 20,
  });

  void handleError(Object error, Emitter<AbsDisplayState<T>> emit) {
    logger.e(error);
    emit(
      state.copyWith(
        status: Status.error,
        message: 'un expected error occurs on display',
      ),
    );
  }
}
