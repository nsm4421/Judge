import 'package:copy_with_extension/copy_with_extension.dart';

import '../base.entity.dart';

part 'pageable.entity.g.dart';

@CopyWith()
class Pageable<T extends BaseEntity> {
  final List<T> data;
  final DateTime? nextCursor;

  Pageable({required this.data, this.nextCursor});

  bool get isEnd => nextCursor != null;

  factory Pageable.from({required List<T> data, int limit = 20}) {
    return Pageable(
      data: data,
      nextCursor: data.length == limit
          ? data
                .map((e) => e.createdAt!)
                .reduce((a, b) => a.isBefore(b) ? a : b)
          : null,
    );
  }
}
