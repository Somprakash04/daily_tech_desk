import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class InterestTopic extends Equatable {
  const InterestTopic({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;

  @override
  List<Object> get props => <Object>[id, label, icon];
}
