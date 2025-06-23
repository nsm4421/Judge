import 'dart:collection';

import 'package:either_dart/either.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

class UpdateAgendaUseCase {
  final AgendaRepository _repository;

  UpdateAgendaUseCase(this._repository);

  static const _minTitleLength = 5;

  Future<Either<AbsError, String>> call({
    required String id,
    required String title,
    required List<String> choices,
  }) async {
    final tasks = ListQueue<Future<Either<AbsError, void>> Function()>();
    tasks.addAll([
      () async {
        // validate title
        return title.isEmpty || title.length < _minTitleLength
            ? Left(ValidationError('제목을 최소 $_minTitleLength 입력해주세요'))
            : Right(null);
      },
      () async {
        // validate choices
        for (final c in choices) {
          if (c.isEmpty) {
            return Left(ValidationError('선택지를 입력해주세요'));
          }
        }
        return Right(null);
      },
      () async => await _repository.create(title: title, choices: choices),
    ]);

    while (tasks.isNotEmpty) {
      final task = tasks.removeFirst();
      final res = await task();
      if (res.isLeft) {
        return Left(res.left);
      }
    }

    return Right(id);
  }
}
