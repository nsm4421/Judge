import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/usecases/export.dart';
import 'package:judge/shared/export.dart';
import '../abs/abs_bloc_state.dart';

part 'sign_in.state.dart';

part 'sign_in.cubit.g.dart';

@injectable
class SignInCubit extends Cubit<SignInState> with SingletonLoggerMixIn {
  SignInCubit(this._useCase) : super(SignInState()) {
    _formKey = GlobalKey<FormState>(debugLabel: 'sign-in-form-key');
  }

  final AuthUseCase _useCase;
  late final GlobalKey<FormState> _formKey;

  GlobalKey<FormState> get formKey => _formKey;

  Future<void> updateStatus({Status? status, String? message}) async {
    emit(
      state.copyWith(
        status: status ?? state.status,
        message: message ?? state.message,
      ),
    );
  }

  Future<void> updateData({String? email, String? password}) async {
    emit(
      state.copyWith(
        email: email ?? state.email,
        password: password ?? state.password,
      ),
    );
  }

  Future<void> submit() async {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    logger.t('email:${state.email}|password:${state.password}');

    updateStatus(status: Status.loading);
    try {
      updateStatus(status: Status.loading, message: 'unexpected error');
      await _useCase
          .signIn(email: state.email, password: state.password)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l.description);
                updateStatus(status: Status.error, message: l.message);
              },
              (r) {
                updateStatus(status: Status.success, message: 'success');
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      updateStatus(status: Status.error, message: 'unexpected error');
    }
  }
}
