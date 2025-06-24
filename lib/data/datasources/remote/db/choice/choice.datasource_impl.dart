import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:either_dart/either.dart';
import 'package:judge/data/models/export.dart';
import 'package:judge/shared/export.dart';

import '../../datasource_response_wrapper.dart';

part 'choice.datasource.dart';

class ChoiceDataSourceImpl
    with DataSourceResponseWrapperMixIn
    implements ChoiceDataSource {
  final PostgrestQueryBuilder _queryBuilder;
  final String? Function() _getCurrentUidCallback;

  ChoiceDataSourceImpl(
    this._queryBuilder, {
    required String? Function() callback,
  }) : _getCurrentUidCallback = callback;

  String get _currentUid {
    final uid = _getCurrentUidCallback();
    if (uid == null) throw AuthException('not logged in');
    return uid;
  }

  @override
  Future<Either<AbsError, int?>> fetchSelected(String agendaId) async =>
      await wrap<int?>(() async {
        final fetched = await _queryBuilder
            .select()
            .eq('id', agendaId)
            .eq('created_by', _currentUid)
            .select();
        return fetched.isEmpty
            ? null
            : FetchChoice.fromJson(fetched.first).selected;
      });

  @override
  Future<Either<AbsError, String>> upsert(EditChoice model) async =>
      await wrap<String>(() async {
        return await _queryBuilder
            .upsert(model.toJson())
            .eq('agenda_id', model.agendaId)
            .eq("created_by", _currentUid)
            .select()
            .single()
            .then(FetchChoice.fromJson)
            .then((res) => res.id);
      });

  @override
  Future<Either<AbsError, void>> deleteByAgendaId(String agendaId) async =>
      await wrap<String>(() async {
        return await _queryBuilder
            .delete()
            .eq('agenda_id', agendaId)
            .eq("created_by", _currentUid)
            .then((res) => res.id);
      });
}
