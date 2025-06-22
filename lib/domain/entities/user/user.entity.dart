import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:judge/data/models/export.dart';

part 'user.entity.g.dart';

@CopyWith()
class AppUser {
  @CopyWithField(immutable: true)
  final String id;
  final String email;
  final String username;

  AppUser({required this.id, required this.email, required this.username});

  factory AppUser.from(AppAuthUser model) {
    return AppUser(id: model.id, email: model.email, username: model.username);
  }
}
