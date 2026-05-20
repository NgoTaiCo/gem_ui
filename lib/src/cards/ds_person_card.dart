import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../primitives/ds_avatar.dart';
import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/shadows.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Tokenized person/group result card.
///
/// Displays a 52dp circle avatar (with divider ring), bold name, and a
/// [surfaceOverlay] pill subtitle. Accent-muted circle trailing arrow.
///
/// Used in search results, add-contact flows, etc.
class DsPersonCard extends StatelessWidget {
  const DsPersonCard({
    super.key,
    required this.name,
    required this.subtitle,
    this.faceUrl,
    this.isGroup = false,
    this.onTap,
  });

  final String name;
  final String subtitle;
  final String? faceUrl;
  final bool isGroup;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding.w,
          vertical: AppSpacing.xs.h,
        ),
        padding: EdgeInsets.all(AppSpacing.md.w),
        decoration: BoxDecoration(
          color: c.surfaceRaised,
          borderRadius: AppRadius.soft,
          boxShadow: AppShadows.lowLight,
        ),
        child: Row(
          children: [
            DsAvatar(
              name: name,
              faceUrl: faceUrl,
              size: 52,
              isGroup: isGroup,
              showRing: true,
            ),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.subheading.copyWith(
                      color: c.contentPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacing.xs.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: c.surfaceOverlay,
                      borderRadius: AppRadius.sharp,
                    ),
                    child: Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: c.contentSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSpacing.sm.w),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: c.accentMuted,
                borderRadius: AppRadius.circle,
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 18.w,
                color: c.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
