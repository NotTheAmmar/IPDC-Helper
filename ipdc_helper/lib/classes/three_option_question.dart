import 'package:ipdc_helper/classes/question.dart';

class ThreeOptionQuestion extends Question {
  final String optionA;
  final String optionB;
  final String optionC;

  ThreeOptionQuestion({
    required super.question,
    required super.answer,
    required this.optionA,
    required this.optionB,
    required this.optionC,
  });

  @override
  String getAnswer() {
    switch (answer) {
      case Option.A:
        return optionA;
      case Option.B:
        return optionB;
      case Option.C:
        return optionC;
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
        return optionC;
      case Option.D:
        return "Unknown";
    }
  }
}
