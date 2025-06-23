import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_agenda.model.freezed.dart';

part 'update_agenda.model.g.dart';

@freezed
@JsonSerializable()
class UpdateAgenda with _$UpdateAgenda {
  final String title;
  final List<String> choices;

  UpdateAgenda({required this.title, required this.choices});

  Map<String, Object?> toJson() => _$UpdateAgendaToJson(this);

  factory UpdateAgenda.fromJson(Map<String, dynamic> json) =>
      _$UpdateAgendaFromJson(json);
}
