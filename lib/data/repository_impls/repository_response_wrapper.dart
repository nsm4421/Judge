import 'package:either_dart/either.dart';
import 'package:judge/shared/export.dart';
import 'package:logger/logger.dart';

mixin class RepositoryResponseWrapperMixIn {
  final _logger = Logger();

  Future<Either<AbsError, S>> wrap<T, S>({
    required Future<Either<AbsError, T>> Function() action,
    AbsError Function(AbsError)? leftCallback,
    required S Function(T) rightCallback,
  }) async {
    try {
      return await action().then(
        (res) => res.fold(
          (l) => Left(leftCallback == null ? l : leftCallback(l)),
          (r) => Right(rightCallback(r)),
        ),
      );
    } catch (e) {
      _logger.e(['UnExpectedError On Repository', e]);
      return Left(UnExpectedError(message: '알 수 없는 오류가 발생했습니다'));
    }
  }
}
