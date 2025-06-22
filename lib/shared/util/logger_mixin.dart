import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
mixin class SingletonLoggerMixIn {
  final logger = Logger();
}
