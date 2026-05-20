import 'package:flutter/material.dart';

/// GEM shadow tokens.
///
/// Selection rule:
/// ```dart
/// boxShadow: AppShadows.lowLight  // always light-only in GEM
/// ```
class AppShadows {
  const AppShadows._();

  /// No elevation.
  static const List<BoxShadow> none = [];

  /// Light theme — low separation: cards, list items, inputs.
  static const List<BoxShadow> lowLight = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x06000000),
      blurRadius: 4,
      spreadRadius: 0,
      offset: Offset(0, 1),
    ),
  ];

  /// Light theme — high separation: modals, prominent floating elements.
  static const List<BoxShadow> highLight = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];
}
