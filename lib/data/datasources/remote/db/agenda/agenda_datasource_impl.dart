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

  String get _selectQueryTemplate => "*, creator:app_users(*)";

  @override
  Future<Either<AbsError, Iterable<FetchAgendaWithUser>>> fetchWithoutCursor({
    int limit = 20,
  }) async => await wrap<Iterable<FetchAgendaWithUser>>(() async {
    return await _queryBuilder
        .select(_selectQueryTemplate)
        .limit(limit)
        .order('created_at', ascending: false)
        .then((res) => res.map(FetchAgendaWithUser.fromJson));
  });

  @override
  Future<Either<AbsError, Iterable<FetchAgendaWithUser>>> fetchWithCursor({
    required String beforeAt,
    int limit = 20,
  }) async => await wrap<Iterable<FetchAgendaWithUser>>(() async {
    return await _queryBuilder
        .select(_selectQueryTemplate)
        // 작성시간(created_at)이 before_at이전엔 데이터 조회
        .lt('created_at', beforeAt)
        .order('created_at', ascending: false)
        .limit(limit)
        .then((res) => res.map(FetchAgendaWithUser.fromJson));
  });

  @override
  Future<Either<AbsError, FetchAgendaWithUser>> fetchById(String id) async =>
      await wrap<FetchAgendaWithUser>(() async {
        return await _queryBuilder
            .select(_selectQueryTemplate)
            .eq("id", id)
            .single()
            .then(FetchAgendaWithUser.fromJson);
      });

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
