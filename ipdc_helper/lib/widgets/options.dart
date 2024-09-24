import 'package:flutter/material.dart';
import 'package:ipdc_helper/classes/four_option_question.dart';
import 'package:ipdc_helper/classes/question.dart';
import 'package:ipdc_helper/classes/three_option_question.dart';
import 'package:ipdc_helper/classes/two_option_question.dart';
import 'package:ipdc_helper/widgets/option_tile.dart';

class Options extends StatefulWidget {
  final Question question;

  final Function(Option) selectOption;

  final Color? Function(Option) getTileColor;

  const Options({
    super.key,
    required this.question,
    required this.selectOption,
    required this.getTileColor,
  });

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  int _numOptions = 0;
  final List<String> _options = [];

  @override
  void initState() {
    super.initState();

    _updateOptions();
  }

  @override
  void didUpdateWidget(covariant Options oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.question != oldWidget.question) {
      _updateOptions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _numOptions,
      itemBuilder: (context, index) {
        return OptionTile(
          option: _options[index],
          type: Option.values[index],
          onTap: () => widget.selectOption(Option.values[index]),
          color: widget.getTileColor(Option.values[index]),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  void _updateOptions() {
    _options.clear();
    switch (widget.question.runtimeType) {
      case const (TwoOptionQuestion):
        TwoOptionQuestion question = widget.question as TwoOptionQuestion;
        _numOptions = 2;
        _options.addAll([question.optionA, question.optionB]);
        break;
      case const (ThreeOptionQuestion):
        ThreeOptionQuestion question = widget.question as ThreeOptionQuestion;
        _numOptions = 3;
        _options.addAll([question.optionA, question.optionB, question.optionC]);
        break;
      case const (FourOptionQuestion):
        FourOptionQuestion question = widget.question as FourOptionQuestion;
        _numOptions = 4;
        _options.addAll([
          question.optionA,
          question.optionB,
          question.optionC,
          question.optionD
        ]);
        break;
    }
  }
}
