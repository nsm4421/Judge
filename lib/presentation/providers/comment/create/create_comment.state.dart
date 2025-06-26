import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:judge/shared/export.dart';

import '../../abs/abs_bloc_state.dart';

part 'create_comment.state.g.dart';

@CopyWith()
class CreateCommentState extends AbsBlocState {
  final String content;

  CreateCommentState({super.status, super.message, this.content = ''});
}
