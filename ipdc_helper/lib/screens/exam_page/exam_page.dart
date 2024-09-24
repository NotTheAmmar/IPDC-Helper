import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipdc_helper/classes/question.dart';
import 'package:ipdc_helper/config.dart';
import 'package:ipdc_helper/extensions.dart';
import 'package:ipdc_helper/main.dart';
import 'package:ipdc_helper/screens/exam_page/widgets/ready_dialog.dart';
import 'package:ipdc_helper/widgets/options.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  late final bool isExam;
  final List<int> _questionsIndex = [];
  final List<Option?> _userAnswers = [];
  int _index = 0;
  int _score = 0;

  Timer _clock = Timer(Duration.zero, () {});

  int _seconds = 0;

  @override
  void initState() {
    super.initState();

    if (Config.instance.showReadyDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          barrierDismissible: false,
          barrierColor: Colors.black87.withOpacity(0.925),
          context: context,
          builder: (context) => ReadyDialog(callback: () => startClock()),
        );
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_questionsIndex.isEmpty) {
      if (context.routeArguments.containsKey('isExam')) {
        isExam = context.routeArguments['isExam'];

        int numQuestions = _totalQuestions();
        while (_questionsIndex.length < numQuestions) {
          int index = Random().nextInt(questions.length);
          if (_questionsIndex.contains(index)) continue;

          _questionsIndex.add(index);
          _userAnswers.add(null);
        }

        if (!Config.instance.showReadyDialog) startClock();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    _clock.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isExam ? "Exam" : "Test"),
        actions: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            shape: const StadiumBorder(),
            color: getTimerColor(),
            child: Padding(
              padding: const EdgeInsets.all(2.5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer,
                    color: context.colorScheme.primaryContainer,
                  ),
                  const Gap(5),
                  Text(
                    "${_formatTime(_seconds)} / ${_formatTime(_totalTime())}",
                  ),
                ],
              ),
            ),
          ),
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
                  "Q. ${questions[_questionsIndex[_index]].question}",
                  style: context.textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              Options(
                question: questions[_questionsIndex[_index]],
                selectOption: selectOption,
                getTileColor: (option) {
                  if (Config.instance.showCorrectAnswer) {
                    return getTileColor(option);
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    return Duration(seconds: seconds).toString().substring(3, 7);
  }

  int _totalQuestions() => isExam ? 70 : 30;

  int _totalTime() => isExam ? 75 : 120;

  Color getTimerColor() {
    if (_seconds <= _totalTime() * 0.1) {
      return Colors.red.shade300;
    } else if (_seconds <= _totalTime() * 0.5) {
      return Colors.orange.shade300;
    } else {
      return Colors.green.shade300;
    }
  }

  void startClock() {
    _clock.cancel();
    _seconds = _totalTime();
    _clock = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds > 0) {
        setState(() => _seconds--);
        return;
      }

      _userAnswers.add(null);
      if (_index < _questionsIndex.length - 1) {
        setState(() => _index++);
        startClock();
      } else {
        context.navigator.pushReplacementNamed(
          '/resultPage',
          arguments: {
            'isExam': isExam,
            'score': _score,
            'questionsIndex': _questionsIndex,
            'userAnswers': _userAnswers
          },
        );
      }
    });
  }

  void selectOption(Option option) {
    if (!_clock.isActive) return;

    _clock.cancel();
    if (questions[_questionsIndex[_index]].answer == option) _score++;

    _userAnswers[_index] = option;
    if (Config.instance.showCorrectAnswer) setState(() {});

    if (_index == _questionsIndex.length - 1) {
      Future.delayed(
        Config.instance.showCorrectAnswer
            ? const Duration(milliseconds: 750)
            : Duration.zero,
        () => context.navigator.pushReplacementNamed(
          '/resultPage',
          arguments: {
            'isExam': isExam,
            'score': _score,
            'questionsIndex': _questionsIndex,
            'userAnswers': _userAnswers
          },
        ),
      );
    } else {
      Future.delayed(
        Config.instance.showCorrectAnswer
            ? const Duration(milliseconds: 750)
            : Duration.zero,
        () => setState(() => _index++),
      );
    }

    Future.delayed(
      Config.instance.showCorrectAnswer
          ? const Duration(milliseconds: 750)
          : Duration.zero,
      () => startClock(),
    );
  }

  Color? getTileColor(Option option) {
    if (_userAnswers[_index] == null) return null;

    if (_userAnswers[_index] == option) {
      if (_userAnswers[_index] == questions[_questionsIndex[_index]].answer) {
        return Colors.green.shade400;
      } else {
        return Colors.red.shade400;
      }
    }

    return null;
  }
}
