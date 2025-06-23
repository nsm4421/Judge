import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/shared/export.dart';

abstract interface class AgendaRepository {
  Future<Either<AbsError, List<Agenda>>> fetchAll();

  Future<Either<AbsError, Agenda>> fetchById(String id);

  Future<Either<AbsError, String>> create({
    required String title,
    required List<String> choices,
  });

  Future<Either<AbsError, String>> update({
    required String id,
    required String title,
    required List<String> choices,
  });

  Future<Either<AbsError, String>> delete(String id);
}
