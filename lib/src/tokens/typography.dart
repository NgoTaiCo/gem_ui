import 'package:flutter/material.dart';

/// GEM typography tokens.
///
/// All presets have no colour set. Always combine with
/// `.copyWith(color: context.colorTokens.contentPrimary)` or similar.
class AppTextStyles {
  const AppTextStyles._();

  static const String fontFamily = 'Inter';

  /// 16px bold — screen titles, key labels, strong headings.
  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.01,
  );

  /// 16px semibold — section titles, card titles, emphasised labels.
  static const TextStyle subheading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.005,
  );

  /// 14px regular — main body copy, field text, descriptions.
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0,
  );

  /// 12px medium — compact labels, badges, metadata requiring emphasis.
  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0,
  );

  /// 12px regular — helper text, timestamps, supporting metadata.
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0,
  );

  static TextTheme textTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: heading.copyWith(color: primary),
      displayMedium: heading.copyWith(color: primary),
      displaySmall: heading.copyWith(color: primary),
      headlineLarge: heading.copyWith(color: primary),
      headlineMedium: heading.copyWith(color: primary),
      headlineSmall: heading.copyWith(color: primary),
      titleLarge: heading.copyWith(color: primary),
      titleMedium: subheading.copyWith(color: primary),
      titleSmall: subheading.copyWith(color: secondary),
      bodyLarge: body.copyWith(color: primary),
      bodyMedium: body.copyWith(color: primary),
      bodySmall: caption.copyWith(color: secondary),
      labelLarge: label.copyWith(color: primary),
      labelMedium: label.copyWith(color: secondary),
      labelSmall: caption.copyWith(color: secondary),
    );
  }
}
