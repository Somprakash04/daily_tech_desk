import 'package:daily_tech_desk/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:daily_tech_desk/core/widgets/app_back_button.dart';

class FeaturePendingPage extends StatelessWidget {
  const FeaturePendingPage({required this.featureName, super.key});

  final String featureName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(fallbackRoute: AppRoutes.home),
        title: Text(featureName),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'This feature will be connected to the backend in Phase 2.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
