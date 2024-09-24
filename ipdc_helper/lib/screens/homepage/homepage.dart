import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipdc_helper/assets.dart';
import 'package:ipdc_helper/extensions.dart';
import 'package:ipdc_helper/main.dart';
import 'package:ipdc_helper/screens/homepage/widgets/home_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _icons = [
    Assets.questionBank,
    Assets.practice,
    Assets.test,
    Assets.exam
  ];
  final List<String> _tiles = ['Question Bank', 'Practice', 'Test', 'Exam'];
  final List<String> _subtitles = [
    'List of ${questions.length} Questions',
    'Self Explanatory, Do I need to say more?',
    '30 Questions with one hour time limit',
    '70 Questions with one hour and thirty minute time limit'
  ];

  final List<String> _routes = [
    '/questionBank',
    '/practicePage',
    '/examPage',
    '/examPage'
  ];

  final List<Map<String, dynamic>> _routeArguments = [
    {},
    {},
    {'isExam': false},
    {'isExam': true}
  ];

  bool _animation = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _animation = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'LogoTag',
              child: CircleAvatar(
                backgroundImage: const AssetImage(Assets.logo),
                backgroundColor: context.colorScheme.onBackground,
              ),
            ),
            const Gap(10),
            const Text('IPDC Helper'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.navigator.pushNamed('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _tiles.length,
        itemBuilder: (context, index) => AnimatedContainer(
          duration: Duration(seconds: 1, milliseconds: index * 500),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(
            _animation ? 0 : -context.mediaQuery.size.width,
            0,
            0,
          ),
          child: HomeTile(
            icon: _icons[index],
            title: _tiles[index],
            subtitle: _subtitles[index],
            route: _routes[index],
            routeArgument: _routeArguments[index],
          ),
        ),
      ),
    );
  }
}
