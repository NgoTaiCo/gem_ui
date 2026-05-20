import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// GEM spacing tokens (logical pixels).
///
/// Use the numeric extension to convert to dp/sp with flutter_screenutil,
/// e.g. `AppSpacing.md.w`, `AppSpacing.md.h`, `AppSpacing.md.sp`.
class AppSpacing {
  const AppSpacing._();

  /// 4 dp — tight gaps, micro spacing, icon padding.
  static const double xs = 4;

  /// 8 dp — small gaps, compact padding.
  static const double sm = 8;

  /// 16 dp — standard content padding and general spacing.
  static const double md = 16;

  /// 24 dp — larger section spacing.
  static const double lg = 24;

  /// 40 dp — hero spacing, large breathing room.
  static const double xl = 40;

  /// 16 dp — default screen/page horizontal padding.
  static const double screenPadding = 16;

  /// 8 dp — message bubble inner padding.
  static const double bubblePadding = 8;

  /// 8 dp — shared list-row padding.
  static const double listItemPadding = 8;
}

/// Convenience extensions on numeric spacing values.
extension AppSpacingExt on double {
  /// Returns a [SizedBox] with the given width (horizontal space).
  SizedBox get horizontalSpace => SizedBox(width: w);

  /// Returns a [SizedBox] with the given height (vertical space).
  SizedBox get verticalSpace => SizedBox(height: h);
}
