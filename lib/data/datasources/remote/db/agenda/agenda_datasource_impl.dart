import 'package:either_dart/either.dart';
import 'package:judge/shared/export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:judge/data/models/export.dart';

import '../../datasource_response_wrapper.dart';

part 'agenda.datasource.dart';

class AgendaDataSourceImpl
    with DataSourceResponseWrapperMixIn
    implements AgendaDataSource {
  final PostgrestQueryBuilder _queryBuilder;

  AgendaDataSourceImpl(this._queryBuilder);

  @override
  Future<Either<AbsError, FetchAgenda>> create(CreateAgenda model) async =>
      await wrap<FetchAgenda>(() async {
        return await _queryBuilder
            .insert(model.toJson())
            .select()
            .single()
            .then(FetchAgenda.fromJson);
      });

  @override
  Future<Either<AbsError, Iterable<FetchAgendaWithUser>>> fetchAll() async =>
      await wrap<Iterable<FetchAgendaWithUser>>(() async {
        return await _queryBuilder.select("*, created_by:app_users(*)").then(
          (res) => res.map(FetchAgendaWithUser.fromJson),
        );
      });

  @override
  Future<Either<AbsError, FetchAgendaWithUser>> fetchById(String id) async =>
      await wrap<FetchAgendaWithUser>(() async {
        return await _queryBuilder
            .select("*, created_by:app_users(*)")
            .eq("id", id)
            .single()
            .then(FetchAgendaWithUser.fromJson);
      });

  @override
  Future<Either<AbsError, FetchAgenda>> update({
    required String id,
    required UpdateAgenda model,
  }) async => await wrap<FetchAgenda>(() async {
    return await _queryBuilder
        .update(model.toJson())
        .eq("id", id)
        .single()
        .then(FetchAgenda.fromJson);
  });

  @override
  Future<Either<AbsError, void>> delete(String id) async =>
      await wrap<void>(() async {
        return await _queryBuilder.delete().eq("id", id);
      });
}
