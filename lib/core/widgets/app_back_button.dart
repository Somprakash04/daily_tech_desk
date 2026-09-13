import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Predictable back navigation for screens opened through named GoRouter routes.
/// Each screen supplies its natural parent route as a safe fallback.
class AppBackButton extends StatelessWidget {
  const AppBackButton({required this.fallbackRoute, super.key});

  final String fallbackRoute;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () => context.goNamed(fallbackRoute),
    );
  }
}
