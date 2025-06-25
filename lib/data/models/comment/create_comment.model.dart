import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_comment.model.freezed.dart';

part 'create_comment.model.g.dart';

@freezed
@JsonSerializable()
class CreateComment with _$CreateComment {
  @JsonKey(name: "agenda_id")
  final String agendaId;
  @JsonKey(name: "parent_id")
  final String? parentId;
  final String content;

  CreateComment({required this.agendaId, this.parentId, required this.content});

  Map<String, Object?> toJson() => _$CreateCommentToJson(this);

  factory CreateComment.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentFromJson(json);
}
