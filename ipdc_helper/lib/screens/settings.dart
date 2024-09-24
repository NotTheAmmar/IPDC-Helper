import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipdc_helper/config.dart';
import 'package:ipdc_helper/extensions.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "General",
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onBackground.withOpacity(0.5),
              ),
            ),
            ListTile(
              title: const Text("Theme"),
              trailing: DropdownButton<ThemeMode>(
                value: Config.instance.themeMode,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('dark'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() => Config.instance.themeMode = value);
                },
                style: context.textTheme.bodySmall,
              ),
            ),
            const Gap(20),
            Text(
              "Test and Exam",
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onBackground.withOpacity(0.5),
              ),
            ),
            SwitchListTile(
              value: Config.instance.showReadyDialog,
              onChanged: (value) {
                setState(() => Config.instance.showReadyDialog = value);
              },
              title: const Text("Show begin dialog"),
            ),
            SwitchListTile(
              value: Config.instance.showCorrectAnswer,
              onChanged: (value) {
                setState(() => Config.instance.showCorrectAnswer = value);
              },
              title: const Text("Show Correct Answer"),
            ),
            const Gap(20),
            const Divider(),
            Center(
              child: Text(
                "Created By Ammar Rangwala",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
