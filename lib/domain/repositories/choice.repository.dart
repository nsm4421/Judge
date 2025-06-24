import 'package:either_dart/either.dart';
import 'package:judge/shared/export.dart';

abstract interface class ChoiceRepository {
  Future<Either<AbsError, int?>> fetchSelected(String agendaId);

  Future<Either<AbsError, String>> upsert({
    required String agendaId,
    required int selected,
  });

  Future<Either<AbsError, void>> deleteByAgendaId(String agendaId);
}
