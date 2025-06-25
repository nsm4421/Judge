import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/auth_user.model.dart';

part 'fetch_comment.model.freezed.dart';

part 'fetch_comment.model.g.dart';

@freezed
@JsonSerializable()
class FetchComment with _$FetchComment {
  final String id;
  @JsonKey(name: "agenda_id")
  final String agendaId;
  @JsonKey(name: "parent_id")
  final String? parentId;
  final String content;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: 'created_by')
  final String createdBy;

  FetchComment({
    required this.id,
    required this.agendaId,
    this.parentId,
    required this.content,
    required this.createdAt,
    required this.createdBy,
  });

  Map<String, Object?> toJson() => _$FetchCommentToJson(this);

  factory FetchComment.fromJson(Map<String, dynamic> json) =>
      _$FetchCommentFromJson(json);
}

@freezed
@JsonSerializable()
class FetchCommentWithUser with _$FetchCommentWithUser {
  final String id;
  @JsonKey(name: "agenda_id")
  final String agendaId;
  @JsonKey(name: "parent_id")
  final String? parentId;
  final String content;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: 'creator')
  final AppAuthUser createdBy;

  FetchCommentWithUser({
    required this.id,
    required this.agendaId,
    this.parentId,
    required this.content,
    required this.createdAt,
    required this.createdBy,
  });

  Map<String, Object?> toJson() => _$FetchCommentWithUserToJson(this);

  factory FetchCommentWithUser.fromJson(Map<String, dynamic> json) =>
      _$FetchCommentWithUserFromJson(json);
}
