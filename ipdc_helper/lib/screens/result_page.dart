import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipdc_helper/classes/question.dart';
import 'package:ipdc_helper/extensions.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> routeData = context.routeArguments;

    bool isExam = routeData['isExam'];
    int score = routeData['score'];
    List<int> questionsIndex = routeData['questionsIndex'];
    List<Option?> userAnswers = routeData['userAnswers'];

    bool pass = score >= _totalScore(isExam) * 0.4;

    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Your Score: $score out of ${_totalScore(isExam)}",
                  style: context.textTheme.titleLarge,
                ),
                const Gap(10),
                Text(
                  pass ? "Pass" : "Fail",
                  style: TextStyle(
                    color: pass ? Colors.green.shade600 : Colors.red.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                  ),
                ),
                const Gap(10),
                Text(
                  pass ? "Good Job!" : "Tough Luck Bruh!",
                  style: context.textTheme.bodyLarge,
                ),
                const Gap(20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton(
                      onPressed: () {
                        context.navigator.pop();
                        context.navigator.pushReplacementNamed('/homepage');
                      },
                      child: const Text("Home"),
                    ),
                    const Gap(20),
                    FilledButton(
                      onPressed: () => context.navigator.pushReplacementNamed(
                        '/examPage',
                        arguments: {"isExam": isExam},
                      ),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
                FilledButton(
                  onPressed: () => context.navigator.pushNamed(
                    '/answerSheetPage',
                    arguments: {
                      'questionsIndex': questionsIndex,
                      "userAnswers": userAnswers
                    },
                  ),
                  child: const Text("Answer Sheet"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _totalScore(bool isExam) => isExam ? 70 : 30;
}
