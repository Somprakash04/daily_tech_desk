import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  /// Switches directly between light and dark. System mode resolves against the
  /// current platform brightness for the first tap.
  void toggle(Brightness platformBrightness) {
    final bool currentlyDark =
        state == ThemeMode.dark ||
        (state == ThemeMode.system && platformBrightness == Brightness.dark);
    emit(currentlyDark ? ThemeMode.light : ThemeMode.dark);
  }
}
