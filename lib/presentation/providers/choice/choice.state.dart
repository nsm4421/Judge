part of 'choice.cubit.dart';

@CopyWith(copyWithNull: true)
class ChoiceState extends AbsBlocState {
  final int? selected;
  final bool isMounted;

  ChoiceState({
    super.status,
    super.message,
    this.selected,
    this.isMounted = false,
  });
}
