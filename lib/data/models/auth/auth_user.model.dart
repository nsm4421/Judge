class AppAuthUser {
  final String id;
  final String email;

  AppAuthUser({required this.id, required this.email});

  factory AppAuthUser.from(Map<String, dynamic> json) {
    return AppAuthUser(id: json['id'], email: json['email']);
  }
}
