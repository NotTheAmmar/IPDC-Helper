import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipdc_helper/app/app.dart';
import 'package:ipdc_helper/assets.dart';
import 'package:ipdc_helper/classes/four_option_question.dart';
import 'package:ipdc_helper/classes/question.dart';
import 'package:ipdc_helper/classes/three_option_question.dart';
import 'package:ipdc_helper/classes/two_option_question.dart';
import 'package:ipdc_helper/config.dart';

final List<Question> questions = [];

void main() {
  Config.instance.initSP().then((_) {
    readQuestions().then((_) => runApp(const App()));
  });
}

Future<void> readQuestions() async {
  Excel excel = Excel.decodeBytes(
    (await rootBundle.load(Assets.questionSheet)).buffer.asUint8List(),
  );

  for (String sheet in excel.tables.keys) {
    for (List<Data?> row in excel.tables[sheet]!.rows) {
      Question question;
      switch (row[0]?.value.toString()) {
        case "2":
          question = TwoOptionQuestion(
            question: row[1]?.value.toString() ?? "Question",
            answer: _getOption(row[4]?.value.toString()),
            optionA: row[2]?.value.toString() ?? "Option A",
            optionB: row[3]?.value.toString() ?? "Option B",
          );
          break;
        case "3":
          question = ThreeOptionQuestion(
            question: row[1]?.value.toString() ?? "Question",
            answer: _getOption(row[5]?.value.toString()),
            optionA: row[2]?.value.toString() ?? "Option A",
            optionB: row[3]?.value.toString() ?? "Option B",
            optionC: row[4]?.value.toString() ?? "Option C",
          );
          break;
        default:
          question = FourOptionQuestion(
            question: row[1]?.value.toString() ?? "Question",
            answer: _getOption(row[6]?.value.toString()),
            optionA: row[2]?.value.toString() ?? "Option A",
            optionB: row[3]?.value.toString() ?? "Option B",
            optionC: row[4]?.value.toString() ?? "Option C",
            optionD: row[5]?.value.toString() ?? "Option D",
          );
          break;
      }
      questions.add(question);
    }
  }
}

Option _getOption(String? option) {
  switch (option) {
    case "A":
      return Option.A;
    case "B":
      return Option.B;
    case "C":
      return Option.C;
    default:
      return Option.D;
  }
}
