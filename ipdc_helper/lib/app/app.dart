import 'package:flutter/material.dart';
import 'package:ipdc_helper/app/theme.dart';
import 'package:ipdc_helper/config.dart';
import 'package:ipdc_helper/screens/answer_sheet_page.dart';
import 'package:ipdc_helper/screens/exam_page/exam_page.dart';
import 'package:ipdc_helper/screens/homepage/homepage.dart';
import 'package:ipdc_helper/screens/practice_page/practice_page.dart';
import 'package:ipdc_helper/screens/question_bank.dart';
import 'package:ipdc_helper/screens/result_page.dart';
import 'package:ipdc_helper/screens/settings.dart';
import 'package:ipdc_helper/screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Config.instance,
      builder: (_, __) {
        return MaterialApp(
          title: 'IPDC Helper',
          themeMode: Config.instance.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          routes: {
            '/splashScreen': (_) => const SplashScreen(),
            '/homepage': (_) => const HomePage(),
            '/settings': (_) => const Settings(),
            '/questionBank': (_) => const QuestionBank(),
            '/practicePage': (_) => const PracticePage(),
            '/examPage': (_) => const ExamPage(),
            '/resultPage': (_) => const ResultPage(),
            '/answerSheetPage': (_) => const AnswerSheetPage(),
          },
          initialRoute: '/splashScreen',
        );
      },
    );
  }
}
