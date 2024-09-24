import 'package:flutter/material.dart';
import 'package:ipdc_helper/classes/question.dart';
import 'package:ipdc_helper/extensions.dart';
import 'package:ipdc_helper/main.dart';
import 'package:ipdc_helper/screens/practice_page/widgets/change_question_dialog.dart';
import 'package:ipdc_helper/widgets/options.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final List<Option?> _userAnswers = List.generate(
    questions.length,
    (_) => null,
  );

  int _index = 0;
  int _correct = 0;
  int _incorrect = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => ChangeQuestionDialog(
                  currQuestion: _index + 1,
                  callback: (newQuestion) {
                    newQuestion = newQuestion.clamp(1, questions.length);

                    setState(() => _index = newQuestion - 1);
                  },
                ),
              ),
              child: Text("${_index + 1} / ${questions.length}"),
            ),
          )
        ],
      ),
      body: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(2.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Q. ${questions[_index].question}",
                  style: context.textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              Options(
                question: questions[_index],
                selectOption: selectOption,
                getTileColor: getTitleColor,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton(
              onPressed: (_index > 0) ? () => setState(() => _index--) : null,
              child: const Text("Previous"),
            ),
            RichText(
              text: TextSpan(
                text: "$_correct ✓",
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.green,
                ),
                children: [
                  TextSpan(
                    text: " | ",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "$_incorrect ✕",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: (_index < questions.length - 1)
                  ? () => setState(() => _index++)
                  : null,
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }

  void selectOption(Option option) {
    if (_userAnswers[_index] != null) return;

    setState(() {
      if (questions[_index].answer == option) {
        _correct++;
      } else {
        _incorrect++;
      }

      _userAnswers[_index] = option;
    });
  }

  Color? getTitleColor(Option option) {
    if (_userAnswers[_index] == null) return null;

    if (_userAnswers[_index] == questions[_index].answer) {
      if (_userAnswers[_index] == option) {
        return Colors.green.shade400;
      }
    } else {
      if (questions[_index].answer == option) {
        return Colors.green.shade400;
      } else if (_userAnswers[_index] == option) {
        return Colors.red.shade400;
      }
    }

    return null;
  }
}
