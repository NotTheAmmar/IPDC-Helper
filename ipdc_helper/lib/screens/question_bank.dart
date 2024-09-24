import 'package:flutter/material.dart';
import 'package:ipdc_helper/extensions.dart';
import 'package:ipdc_helper/main.dart';

class QuestionBank extends StatelessWidget {
  const QuestionBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Question Bank")),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                "${index + 1}. ${questions[index].question}",
                style: context.textTheme.titleMedium,
              ),
              subtitle: Text(
                "Answer: ${questions[index].getAnswer()}",
                style: context.textTheme.bodySmall,
              ),
            ),
          );
        },
      ),
    );
  }
}
