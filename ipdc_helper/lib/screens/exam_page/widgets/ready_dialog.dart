import 'package:flutter/material.dart';
import 'package:ipdc_helper/extensions.dart';

class ReadyDialog extends StatelessWidget {
  final VoidCallback callback;

  const ReadyDialog({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(child: Text("Ready?", style: context.textTheme.titleLarge)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton(
              onPressed: () {
                context.navigator.pop();
                context.navigator.pop();
              },
              child: const Text("No"),
            ),
            FilledButton(
              onPressed: () {
                context.navigator.pop();
                callback();
              },
              child: const Text("Yes"),
            ),
          ],
        ),
      ],
    );
  }
}
