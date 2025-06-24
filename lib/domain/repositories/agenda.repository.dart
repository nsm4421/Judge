import 'package:either_dart/either.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/shared/export.dart';

abstract interface class AgendaRepository {
  Future<Either<AbsError, Pageable<Agenda>>> fetchWithPage({
    String? beforeAt,
    int limit = 20,
  });

  Future<Either<AbsError, Agenda>> getById(String id);

  Future<Either<AbsError, String>> create({
    required String title,
    required List<String> options,
  });

  Future<Either<AbsError, String>> update({
    required String id,
    required String title,
    required List<String> options,
  });

  Future<Either<AbsError, String>> delete(String id);
}
