import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_agenda.model.freezed.dart';

part 'create_agenda.model.g.dart';

@freezed
@JsonSerializable()
class CreateAgenda with _$CreateAgenda {
  final String title;
  final List<String> choices;
  late final List<int> counts;

  CreateAgenda({required this.title, required this.choices}) {
    this.counts = choices.map((_) => 0).toList();
  }

  Map<String, Object?> toJson() => _$CreateAgendaToJson(this);

  factory CreateAgenda.fromJson(Map<String, dynamic> json) =>
      _$CreateAgendaFromJson(json);
}
