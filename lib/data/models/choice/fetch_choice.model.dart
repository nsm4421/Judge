import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_choice.model.freezed.dart';

part 'fetch_choice.model.g.dart';

@freezed
@JsonSerializable()
class FetchChoice with _$FetchChoice {
  final String id;
  @JsonKey(name: "agenda_id")
  final String agendaId;
  final int selected;
  @JsonKey(name: "created_at")
  final String createdAt;

  FetchChoice({
    required this.id,
    required this.agendaId,
    required this.selected,
    required this.createdAt
  });

  Map<String, Object?> toJson() => _$FetchChoiceToJson(this);

  factory FetchChoice.fromJson(Map<String, dynamic> json) =>
      _$FetchChoiceFromJson(json);
}
