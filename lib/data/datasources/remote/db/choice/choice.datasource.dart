part of 'choice.datasource_impl.dart';

abstract interface class ChoiceDataSource {
  Future<Either<AbsError, int?>> fetchSelected(String agendaId);

  Future<Either<AbsError, String>> upsert(EditChoice model);

  Future<Either<AbsError, void>> deleteByAgendaId(String agendaId);
}
