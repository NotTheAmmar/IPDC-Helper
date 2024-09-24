import 'package:flutter/material.dart';
import 'package:ipdc_helper/extensions.dart';

class HomeTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  final String route;
  final Map<String, dynamic> routeArgument;

  const HomeTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.routeArgument,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.navigator.pushNamed(
          route,
          arguments: routeArgument,
        ),
        leading: CircleAvatar(
          backgroundColor: context.colorScheme.onBackground,
          backgroundImage: AssetImage(icon),
        ),
        title: Text(title, style: context.textTheme.titleMedium),
        subtitle: Text(subtitle, style: context.textTheme.bodySmall),
      ),
    );
  }
}
