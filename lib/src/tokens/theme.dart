import 'package:flutter/material.dart';

import 'color_tokens.dart';
import 'typography.dart';

/// GEM theme factory — light-mode only.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: GemTheme.light(),
///   ...
/// )
/// ```
class GemTheme {
  const GemTheme._();

  static ThemeData light() {
    final colorTokens = AppColorTokens.light();
    final textTheme = AppTextStyles.textTheme(
      colorTokens.contentPrimary,
      colorTokens.contentSecondary,
    );

    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: colorTokens.accent,
      scaffoldBackgroundColor: colorTokens.surface,
      canvasColor: colorTokens.surface,
      colorScheme: ColorScheme.light(
        primary: colorTokens.accent,
        onPrimary: colorTokens.onAccent,
        secondary: colorTokens.accent,
        onSecondary: colorTokens.onAccent,
        error: colorTokens.stateError,
        onError: colorTokens.onAccent,
        surface: colorTokens.surfaceRaised,
        onSurface: colorTokens.contentPrimary,
      ),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      dividerColor: colorTokens.divider,
      extensions: <ThemeExtension<dynamic>>[colorTokens],
    );
  }
}
