import 'package:daily_tech_desk/features/onboarding/domain/entities/interest_topic.dart';
import 'package:flutter/material.dart';

abstract final class DummyCategories {
  static const String allFeedLabel = 'All';
  static const String allTechnologyId = 'all-technology';
  static const List<String> defaultHomeCategoryIds = <String>[
    'flutter',
    'ai',
    'android',
    'programming',
    'big-tech',
  ];

  static const List<InterestTopic> interests = <InterestTopic>[
    InterestTopic(
      id: allTechnologyId,
      label: 'All Technology',
      icon: Icons.grid_view_rounded,
    ),
    InterestTopic(id: 'ai', label: 'AI', icon: Icons.auto_awesome_rounded),
    InterestTopic(
      id: 'machine-learning',
      label: 'Machine Learning',
      icon: Icons.psychology_rounded,
    ),
    InterestTopic(
      id: 'flutter',
      label: 'Flutter',
      icon: Icons.flutter_dash_rounded,
    ),
    InterestTopic(id: 'android', label: 'Android', icon: Icons.android_rounded),
    InterestTopic(id: 'ios', label: 'iOS', icon: Icons.phone_iphone_rounded),
    InterestTopic(id: 'java', label: 'Java', icon: Icons.coffee_rounded),
    InterestTopic(id: 'kotlin', label: 'Kotlin', icon: Icons.code_rounded),
    InterestTopic(
      id: 'javascript',
      label: 'JavaScript',
      icon: Icons.javascript_rounded,
    ),
    InterestTopic(
      id: 'typescript',
      label: 'TypeScript',
      icon: Icons.data_object_rounded,
    ),
    InterestTopic(id: 'python', label: 'Python', icon: Icons.terminal_rounded),
    InterestTopic(id: 'cpp', label: 'C++', icon: Icons.memory_rounded),
    InterestTopic(id: 'cloud', label: 'Cloud', icon: Icons.cloud_queue_rounded),
    InterestTopic(
      id: 'cyber-security',
      label: 'Cyber Security',
      icon: Icons.security_rounded,
    ),
    InterestTopic(
      id: 'devops',
      label: 'DevOps',
      icon: Icons.settings_suggest_rounded,
    ),
    InterestTopic(
      id: 'big-tech',
      label: 'Big Tech',
      icon: Icons.apartment_rounded,
    ),
    InterestTopic(
      id: 'startups',
      label: 'Startups',
      icon: Icons.rocket_launch_rounded,
    ),
    InterestTopic(
      id: 'programming',
      label: 'Programming',
      icon: Icons.developer_mode_rounded,
    ),
    InterestTopic(
      id: 'web-development',
      label: 'Web Development',
      icon: Icons.language_rounded,
    ),
    InterestTopic(
      id: 'open-source',
      label: 'Open Source',
      icon: Icons.hub_rounded,
    ),
  ];
}
