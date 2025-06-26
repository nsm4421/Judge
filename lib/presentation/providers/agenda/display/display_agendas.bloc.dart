import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/entities/export.dart';
import 'package:judge/domain/usecases/export.dart';
import '../../abs/abs_display.bloc.dart';
import 'package:judge/shared/export.dart';

@injectable
class DisplayAgendasBloc extends AbsDisplayBloc<Agenda> {
  final AgendaUseCase _useCase;

  DisplayAgendasBloc(this._useCase);

  @override
  Future<Either<AbsError, Pageable<Agenda>>> handleFetch({
    DateTime? cursor,
    int limit = 20,
  }) async {
    return await _useCase.fetch(beforeAt: cursor, limit: limit);
  }
}
