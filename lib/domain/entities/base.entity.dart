import 'user/user.entity.dart';

abstract class BaseEntity {
  final String id;
  final DateTime? createdAt;
  final AppUser? createdBy;

  BaseEntity({required this.id, this.createdAt, this.createdBy});
}
