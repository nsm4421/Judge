import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_choice.model.freezed.dart';

part 'edit_choice.model.g.dart';

@freezed
@JsonSerializable()
class EditChoice with _$EditChoice {
  @JsonKey(name: "agenda_id")
  final String agendaId;
  final int selected;

  EditChoice({required this.agendaId, required this.selected});

  Map<String, Object?> toJson() => _$EditChoiceToJson(this);

  factory EditChoice.fromJson(Map<String, dynamic> json) =>
      _$EditChoiceFromJson(json);
}
