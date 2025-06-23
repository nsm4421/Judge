import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:judge/data/models/export.dart';

import '../base.entity.dart';
import '../user/user.entity.dart';

part 'agenda.entity.g.dart';

@CopyWith()
class Agenda extends BaseEntity {
  @CopyWithField(immutable: true)
  final String title;
  final List<String> choices;
  final List<int> counts;

  Agenda({
    required super.id,
    required this.title,
    required this.choices,
    required this.counts,
    required super.createdBy,
    super.createdAt,
  });

  factory Agenda.from(FetchAgendaWithUser model) {
    return Agenda(
      id: model.id,
      title: model.title,
      choices: model.choices,
      counts: model.counts,
      createdBy: AppUser.from(model.createdBy),
      createdAt: model.createdAt == null
          ? null
          : DateTime.tryParse(model.createdAt!),
    );
  }

  Agenda get sorted {
    final indices = List<int>.generate(counts.length, (i) => i);
    indices.sort((a, b) => counts[b].compareTo(counts[a]));
    final sortedOptions = indices.map((i) => choices[i]).toList();
    final sortedCounts = indices.map((i) => counts[i]).toList();
    return copyWith(choices: sortedOptions, counts: sortedCounts);
  }
}
