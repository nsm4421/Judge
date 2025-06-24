import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/data/datasources/export.dart';
import 'package:judge/data/models/export.dart';
import 'package:judge/domain/repositories/export.dart';
import 'package:judge/shared/export.dart';

import 'repository_response_wrapper.dart';

@LazySingleton(as: ChoiceRepository)
class ChoiceRepositoryImpl
    with RepositoryResponseWrapperMixIn
    implements ChoiceRepository {
  final ChoiceDataSource _remoteDataSource;

  ChoiceRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AbsError, String>> upsert({
    required String agendaId,
    required int selected,
  }) async {
    return await _remoteDataSource.upsert(
      EditChoice(agendaId: agendaId, selected: selected),
    );
  }

  @override
  Future<Either<AbsError, int?>> fetchSelected(String agendaId) async {
    return await _remoteDataSource.fetchSelected(agendaId);
  }

  @override
  Future<Either<AbsError, void>> deleteByAgendaId(String agendaId) async {
    return await _remoteDataSource.deleteByAgendaId(agendaId);
  }
}
