import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:judge/data/models/export.dart';

import '../user/user.entity.dart';

part 'agenda.entity.g.dart';

@CopyWith()
class Agenda {
  @CopyWithField(immutable: true)
  final String id;
  final String title;
  final List<String> options;
  final List<int> counts;
  final AppUser createdBy;
  final DateTime? createdAt;

  Agenda({
    required this.id,
    required this.title,
    required this.options,
    required this.counts,
    required this.createdBy,
    this.createdAt,
  });

  factory Agenda.from(FetchAgendaWithUser model) {
    return Agenda(
      id: model.id,
      title: model.title,
      options: model.choices,
      counts: model.counts,
      createdBy: AppUser.from(model.createdBy),
      createdAt: model.createdAt == null
          ? null
          : DateTime.tryParse(model.createdAt!),
    );
  }
}
