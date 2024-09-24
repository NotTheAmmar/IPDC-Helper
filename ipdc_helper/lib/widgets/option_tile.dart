import 'package:flutter/material.dart';
import 'package:ipdc_helper/classes/question.dart';
import 'package:ipdc_helper/extensions.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final Option type;

  final Color? color;

  final VoidCallback? onTap;

  const OptionTile({
    super.key,
    required this.option,
    required this.type,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${type.name}. $option", style: context.textTheme.bodyMedium),
      onTap: onTap,
      tileColor: color,
    );
  }
}
