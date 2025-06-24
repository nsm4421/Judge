import 'package:injectable/injectable.dart';
import 'package:judge/domain/repositories/export.dart';
import 'scenario/edit_choice.usecase.dart';
import 'scenario/fetch_current_user_choice.usecase.dart';

@lazySingleton
class ChoiceUseCase {
  final ChoiceRepository _repository;

  ChoiceUseCase(this._repository);

  EditChoiceUseCase get edit => EditChoiceUseCase(_repository);

  FetchCurrentUserChoiceUseCase get fetch =>
      FetchCurrentUserChoiceUseCase(_repository);
}
