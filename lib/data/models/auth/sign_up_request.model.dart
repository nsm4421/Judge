import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.model.freezed.dart';

part 'sign_up_request.model.g.dart';

@freezed
@JsonSerializable()
class SignUpRequest with _$SignUpRequest {
  final String email;
  final String password;

  SignUpRequest({required this.email, required this.password});

  Map<String, Object?> toJson() => _$SignUpRequestToJson(this);

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);
}
