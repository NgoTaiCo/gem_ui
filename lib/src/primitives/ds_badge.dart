import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Compact count/unread badge.
///
/// - [DsBadge.count] — pill with numeric count (hidden when count ≤ 0)
/// - [DsBadge.dot]   — 8 dp presence/activity dot
class DsBadge extends StatelessWidget {
  /// Numeric badge.
  const DsBadge.count({
    super.key,
    required this.count,
    this.maxCount = 99,
  }) : _isDot = false;

  /// Dot badge — solid 8 dp circle.
  const DsBadge.dot({super.key})
      : _isDot = true,
        count = 0,
        maxCount = 0;

  final int count;
  final int maxCount;
  final bool _isDot;

  String get _label => count > maxCount ? '$maxCount+' : '$count';

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    if (_isDot) {
      return Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(
          color: c.unreadCount,
          shape: BoxShape.circle,
        ),
      );
    }

    if (count <= 0) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xs.w + 2,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: c.unreadCount,
        borderRadius: AppRadius.circle,
      ),
      child: Text(
        _label,
        style: AppTextStyles.caption.copyWith(
          color: c.onAccent,
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
