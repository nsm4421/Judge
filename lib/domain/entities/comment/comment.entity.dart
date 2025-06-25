import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:judge/data/models/export.dart';
import '../base.entity.dart';

import '../user/user.entity.dart';

part 'comment.entity.g.dart';

@CopyWith(copyWithNull: true)
class Comment extends BaseEntity {
  final String? parentId;
  final String content;

  Comment({
    required super.id,
    this.parentId,
    required this.content,
    super.createdAt,
    super.createdBy,
  });

  bool get isParent => parentId != null;

  bool get isChild => !isParent;

  factory Comment.fromModelWithUser(FetchCommentWithUser model) {
    return Comment(
      id: model.id,
      content: model.content,
      createdAt: DateTime.tryParse(model.createdAt),
      createdBy: AppUser.from(model.createdBy),
    );
  }

  factory Comment.fromModel(FetchComment model) {
    return Comment(
      id: model.id,
      content: model.content,
      createdAt: DateTime.tryParse(model.createdAt),
      createdBy: null,
    );
  }
}
