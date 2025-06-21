import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:injectable/injectable.dart';

import 'package:judge/shared/export.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/usecases/export.dart';
import 'package:logger/logger.dart';

part 'auth.bloc.g.dart';

part 'auth.state.dart';

part 'auth.event.dart';

@lazySingleton
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._useCase) : super(AuthenticationState()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
  }

  final AuthUseCase _useCase;
  final Logger _logger = Logger();

  Stream<AppUser?> get userStream => _useCase.userStream;

  Future<void> _onSignIn(
    SignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await _useCase
          .signIn(email: event.email, password: event.password)
          .then(
            (res) => res.fold(
              (l) {
                _logger.e(l.description);
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
      _logger.e(error);
      emit(
        state
            .copyWith(status: Status.error, message: 'unexpected error')
            .copyWithNull(user: true),
      );
    }
  }

  Future<void> _onSignUp(
    SignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await _useCase
          .signUp(email: event.email, password: event.password)
          .then(
            (res) => res.fold(
              (l) {
                _logger.e(l.description);
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
      _logger.e(error);
      emit(
        state
            .copyWith(status: Status.error, message: 'unexpected error')
            .copyWithNull(user: true),
      );
    }
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      await _useCase.signOut().then(
        (res) => res.fold(
          (l) {
            _logger.e(l.description);
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
      _logger.e(error);
      emit(
        state
            .copyWith(status: Status.error, message: 'unexpected error')
            .copyWithNull(user: true),
      );
    }
  }
}
