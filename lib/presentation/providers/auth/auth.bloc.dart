import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:injectable/injectable.dart';

import 'package:judge/shared/export.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/usecases/export.dart';

import '../abs/abs_bloc_state.dart';

part 'auth.bloc.g.dart';

part 'auth.state.dart';

part 'auth.event.dart';

@lazySingleton
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with SingletonLoggerMixIn {
  AuthenticationBloc(this._useCase) : super(AuthenticationState()) {
    on<SignOutEvent>(_onSignOut);
  }

  final AuthUseCase _useCase;

  Stream<AppUser?> get userStream => _useCase.userStream;

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await _useCase.signOut().then(
        (res) => res.fold(
          (l) {
            logger.e(l);
            emit(
              state
                  .copyWith(status: Status.error, message: l.message)
                  .copyWithNull(user: true),
            );
          },
          (r) {
            emit(state.copyWith(status: Status.success));
          },
        ),
      );
    } catch (error) {
      logger.e(error);
      emit(
        state
            .copyWith(status: Status.error, message: 'unexpected error')
            .copyWithNull(user: true),
      );
    }
  }
}
