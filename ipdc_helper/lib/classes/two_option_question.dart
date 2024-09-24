import 'package:ipdc_helper/classes/question.dart';

class TwoOptionQuestion extends Question {
  final String optionA;
  final String optionB;

  TwoOptionQuestion({
    required super.question,
    required super.answer,
    required this.optionA,
    required this.optionB,
  });

  @override
  String getAnswer() {
    switch (answer) {
      case Option.A:
        return optionA;
      case Option.B:
        return optionB;
      case Option.C:
      case Option.D:
        return "Unknown";
    }
  }

  @override
  String getOption(Option option) {
    switch (option) {
      case Option.A:
        return optionA;
      case Option.B:
        return optionB;
      case Option.C:
      case Option.D:
        return "Unknown";
    }
  }
}
