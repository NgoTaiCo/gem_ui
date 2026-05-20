import 'package:flutter/material.dart';

/// GEM border-radius tokens.
///
/// All tokens return [BorderRadius] objects directly.
/// Usage: `borderRadius: AppRadius.soft`
/// Do NOT write: `BorderRadius.circular(AppRadius.soft)`
class AppRadius {
  const AppRadius._();

  /// 4 dp — small chips, sharp pills, micro containers.
  static const BorderRadius sharp = BorderRadius.all(Radius.circular(4));

  /// 10 dp — buttons, text fields, cards.
  static const BorderRadius soft = BorderRadius.all(Radius.circular(10));

  /// 18 dp — chat bubbles, rounded floating elements.
  static const BorderRadius round = BorderRadius.all(Radius.circular(18));

  /// 999 dp — avatars, full pills, circular shapes.
  static const BorderRadius circle = BorderRadius.all(Radius.circular(999));
}
