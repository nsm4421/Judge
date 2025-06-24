import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/auth_datasource_impl.dart';
import 'db/agenda/agenda_datasource_impl.dart';
import 'db/choice/choice.datasource_impl.dart';

@module
abstract class RemoteDataSource {
  final _supabaseClient = Supabase.instance.client;

  @lazySingleton
  String? Function() get _getCurrentUidCallback =>
      () => _supabaseClient.auth.currentUser?.id;

  @lazySingleton
  AuthDataSource get auth => AuthDataSourceImpl(_supabaseClient.auth);

  @lazySingleton
  AgendaDataSource get agenda =>
      AgendaDataSourceImpl(_supabaseClient.rest.from("agendas"));

  @lazySingleton
  ChoiceDataSource get choice => ChoiceDataSourceImpl(
    _supabaseClient.rest.from("choices"),
    callback: _getCurrentUidCallback,
  );
}
