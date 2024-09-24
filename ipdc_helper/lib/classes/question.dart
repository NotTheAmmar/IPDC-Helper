enum Option { A, B, C, D }

abstract class Question {
  Question({required this.question, required this.answer});

  final String question;

  final Option answer;

  String getAnswer();

  String getOption(Option option);
}
