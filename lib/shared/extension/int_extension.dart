import 'package:flutter/cupertino.dart';

extension IntExtension on int {
  Duration get durationInSec => Duration(seconds: this);

  Duration get durationInMillis => Duration(milliseconds: this);

  SizedBox get width => SizedBox(width: toDouble());

  SizedBox get height => SizedBox(height: toDouble());
}
