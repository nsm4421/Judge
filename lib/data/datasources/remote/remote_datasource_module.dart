import 'package:injectable/injectable.dart';
import 'package:judge/shared/export.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/auth_datasource_impl.dart';
import 'db/agenda/agenda_datasource_impl.dart';

@module
abstract class RemoteDataSource with SingletonLoggerMixIn{
  final _supabaseClient = Supabase.instance.client;

  @lazySingleton
  AuthDataSource get auth =>
      AuthDataSourceImpl(_supabaseClient.auth, logger: logger);

  @lazySingleton
  AgendaDataSource get agenda => AgendaDataSourceImpl(
    _supabaseClient.rest.from("agenda"),
    logger: logger,
  );
}
