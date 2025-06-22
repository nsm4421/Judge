import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/usecases/export.dart';
import '../abs/abs_bloc_state.dart';
import 'package:judge/shared/export.dart';

part 'sign_up.state.dart';

part 'sign_up.cubit.g.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> with SingletonLoggerMixIn {
  SignUpCubit(this._useCase) : super(SignUpState()) {
    _formKey = GlobalKey<FormState>(debugLabel: 'sign-up-form-key');
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

  Future<void> updateData({
    String? email,
    String? password,
    String? username,
  }) async {
    emit(
      state.copyWith(
        email: email ?? state.email,
        password: password ?? state.password,
        username: username ?? state.username,
      ),
    );
  }

  Future<void> submit() async {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }

    updateStatus(status: Status.loading);
    try {
      updateStatus(status: Status.loading, message: 'unexpected error');
      await _useCase
          .signUp(
            email: state.email,
            password: state.password,
            username: state.username,
          )
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
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
