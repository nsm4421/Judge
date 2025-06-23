import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:judge/shared/export.dart';

class ChoiceModalFragment extends StatefulWidget {
  const ChoiceModalFragment({super.key, this.initValue, required this.choices});

  final String? initValue;
  final List<String> choices;

  @override
  State<ChoiceModalFragment> createState() => _ChoiceModalFragmentState();
}

class _ChoiceModalFragmentState extends State<ChoiceModalFragment> {
  late final TextEditingController _controller;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..text = widget.initValue ?? '';
    _formKey = GlobalKey<FormState>(debugLabel: 'choice-modal');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String? _validator(String? text) {
    if (text == null || text.isEmpty) {
      return '텍스트를 입력해주세요';
    } else if (text == widget.initValue) {
      return '기존과 동일한 텍스트를 입력하였습니다';
    } else if (widget.choices.contains(text)) {
      return '중복된 텍스트입니다';
    }
    return null;
  }

  _handleSubmit() async {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    FocusScope.of(context).unfocus();
    context.pop<String>(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colorScheme.tertiaryContainer.withAlpha(50),
      ),
      child: Form(
        key: _formKey,
        child: TextFormField(
          autofocus: true,
          validator: _validator,
          controller: _controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: _handleSubmit,
              tooltip: 'edit',
              icon: Icon(Icons.edit_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
