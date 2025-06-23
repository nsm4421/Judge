import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/data/datasources/export.dart';
import 'package:judge/data/models/export.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';
import 'repository_response_wrapper.dart';

@LazySingleton(as: AgendaRepository)
class AgendaRepositoryImpl
    with RepositoryResponseWrapperMixIn
    implements AgendaRepository {
  final AgendaDataSource _remoteDataSource;

  AgendaRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AbsError, String>> create({
    required String title,
    required List<String> choices,
  }) async => await wrap<FetchAgenda, String>(
    action: () async => await _remoteDataSource.create(
      CreateAgenda(title: title, choices: choices),
    ),
    rightCallback: (e) => e.id,
  );

  @override
  Future<Either<AbsError, List<Agenda>>> fetchAll() async =>
      await wrap<Iterable<FetchAgendaWithUser>, List<Agenda>>(
        action: () async => await _remoteDataSource.fetchAll(),
        rightCallback: (e) => e.map(Agenda.from).toList(),
      );

  @override
  Future<Either<AbsError, Agenda>> fetchById(String id) async =>
      await wrap<FetchAgendaWithUser, Agenda>(
        action: () async => await _remoteDataSource.fetchById(id),
        rightCallback: Agenda.from,
      );

  @override
  Future<Either<AbsError, String>> update({
    required String id,
    required String title,
    required List<String> choices,
  }) async => await wrap<FetchAgenda, String>(
    action: () async => await _remoteDataSource.update(
      id: id,
      model: UpdateAgenda(title: title, choices: choices),
    ),
    rightCallback: (e) => e.id,
  );

  @override
  Future<Either<AbsError, String>> delete(String id) async =>
      await wrap<void, String>(
        action: () async => await _remoteDataSource.delete(id),
        rightCallback: (e) => id,
      );
}
