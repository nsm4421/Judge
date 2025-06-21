import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_request.model.freezed.dart';

part 'sign_in_request.model.g.dart';

@freezed
@JsonSerializable()
class SignInRequest with _$SignInRequest {
  final String email;
  final String password;

  SignInRequest({required this.email, required this.password});

  Map<String, Object?> toJson() => _$SignInRequestToJson(this);

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);
}
