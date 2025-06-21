import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/auth_datasource_impl.dart';
import 'db/agenda/agenda_datasource_impl.dart';

@module
abstract class RemoteDataSource {
  final _supabaseClient = Supabase.instance.client;
  final _logger = Logger();

  @lazySingleton
  AuthDataSource get auth =>
      AuthDataSourceImpl(_supabaseClient.auth, logger: _logger);

  @lazySingleton
  AgendaDataSource get agenda => AgendaDataSourceImpl(
    _supabaseClient.rest.from("agenda"),
    logger: _logger,
  );
}
