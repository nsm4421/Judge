import 'dart:collection';

import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class CreateAgendaUseCase {
  final AgendaRepository _repository;

  CreateAgendaUseCase(this._repository);

  static const _minTitleLength = 5;

  Future<Either<AbsError, String>> call({
    required String title,
    required List<String> options,
  }) async {
    String? savedId;
    final tasks = ListQueue<Future<Either<AbsError, void>> Function()>();
    tasks.addAll([
      () async {
        // validate title
        return title.isEmpty || title.length < _minTitleLength
            ? Left(ValidationError('제목을 최소 $_minTitleLength 입력해주세요'))
            : Right(null);
      },
      () async {
        // validate options
        for (final c in options) {
          if (c.isEmpty) {
            return Left(ValidationError('선택지를 입력해주세요'));
          }
        }
        return Right(null);
      },
      () async {
        final res = await _repository.create(title: title, options: options);
        if (res.isRight) {
          savedId = res.right;
        }
        return res;
      },
    ]);

    while (tasks.isNotEmpty) {
      final task = tasks.removeFirst();
      final res = await task();
      if (res.isLeft) {
        return Left(res.left);
      }
    }

    return Right(savedId!);
  }
}
