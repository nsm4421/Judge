import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.model.freezed.dart';

part 'auth_user.model.g.dart';

@freezed
@JsonSerializable()
class AppAuthUser with _$AppAuthUser {
  final String id;
  final String email;
  final String username;

  AppAuthUser({required this.id, required this.email, required this.username});

  factory AppAuthUser.fromJson(Map<String, dynamic> json) =>
      _$AppAuthUserFromJson(json);
}
