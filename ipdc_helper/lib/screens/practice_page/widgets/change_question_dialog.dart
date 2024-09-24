import 'package:flutter/material.dart';
import 'package:ipdc_helper/extensions.dart';

class ChangeQuestionDialog extends StatelessWidget {
  final void Function(int) callback;
  final TextEditingController _controller;

  ChangeQuestionDialog({
    super.key,
    required int currQuestion,
    required this.callback,
  }) : _controller = TextEditingController(text: "$currQuestion");

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      title: Text("Change Question", style: context.textTheme.titleMedium),
      content: Form(
        key: _key,
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            hintText: "Question Number",
            hintStyle: context.textTheme.bodyMedium,
            labelText: "Question Number",
            labelStyle: context.textTheme.bodySmall,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return "Required";

            return null;
          },
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => context.navigator.pop(),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            _key.currentState?.validate();
            if (_controller.text.isNotEmpty) {
              context.navigator.pop();
              callback(int.parse(_controller.text));
            }
          },
          child: const Text("Goto"),
        ),
      ],
    );
  }
}
