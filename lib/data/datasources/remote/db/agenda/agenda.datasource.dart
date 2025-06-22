part of 'agenda_datasource_impl.dart';

abstract interface class AgendaDataSource {
  Future<Either<AbsError, Iterable<FetchAgenda>>> fetchAll();

  Future<Either<AbsError, FetchAgenda>> fetchById(String id);

  Future<Either<AbsError, FetchAgenda>> create(CreateAgenda model);

  Future<Either<AbsError, FetchAgenda>> update({
    required String id,
    required UpdateAgenda model,
  });

  Future<Either<AbsError, void>> delete(String id);
}
