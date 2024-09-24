import 'package:flutter/material.dart';
import 'package:ipdc_helper/classes/question.dart';
import 'package:ipdc_helper/extensions.dart';
import 'package:ipdc_helper/main.dart';

class AnswerSheetPage extends StatelessWidget {
  const AnswerSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> routeData = context.routeArguments;

    List<int> questionsIndex = routeData['questionsIndex'];
    List<Option?> userAnswers = routeData['userAnswers'];

    return Scaffold(
      appBar: AppBar(title: const Text("Answer Sheet")),
      body: ListView.builder(
        itemCount: questionsIndex.length,
        itemBuilder: (context, index) {
          bool rightAnswer =
              questions[questionsIndex[index]].answer == userAnswers[index];

          return Card(
            child: ListTile(
              title: Text(
                questions[questionsIndex[index]].question,
                style: context.textTheme.bodyLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userAnswers[index] == null)
                    Text(
                      "Answer Not Given",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.red.shade600,
                      ),
                    )
                  else
                    Text(
                      "Your Answer: ${questions[questionsIndex[index]].getOption(userAnswers[index]!)}",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: rightAnswer
                            ? Colors.green.shade600
                            : Colors.red.shade600,
                      ),
                    ),
                  if (!rightAnswer)
                    Text(
                      "Correct Answer: ${questions[questionsIndex[index]].getAnswer()}",
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.green.shade600,
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
