import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/auth_user.model.dart';

part 'fetch_agenda.model.freezed.dart';

part 'fetch_agenda.model.g.dart';

@freezed
@JsonSerializable()
class FetchAgenda with _$FetchAgenda {
  final String id;
  final String title;
  final List<String> choices;
  final List<int> counts;

  FetchAgenda({
    required this.id,
    required this.title,
    required this.choices,
    required this.counts,
  });

  factory FetchAgenda.fromJson(Map<String, dynamic> json) =>
      _$FetchAgendaFromJson(json);
}

@freezed
@JsonSerializable()
class FetchAgendaWithUser with _$FetchAgendaWithUser {
  final String id;
  final String title;
  final List<String> choices;
  final List<int> counts;
  @JsonKey(name: 'creator')
  final AppAuthUser createdBy;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  FetchAgendaWithUser({
    required this.id,
    required this.title,
    required this.choices,
    required this.counts,
    required this.createdBy,
    this.createdAt,
  });

  factory FetchAgendaWithUser.fromJson(Map<String, dynamic> json) =>
      _$FetchAgendaWithUserFromJson(json);
}
