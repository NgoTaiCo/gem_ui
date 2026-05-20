import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../primitives/ds_avatar.dart';
import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/shadows.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Bottom sheet that displays a list of selected entities.
///
/// Uses a plain [List<T>] — no GetX / RxList dependency. For reactive
/// updates, wrap the parent call site in an [Obx] or [StreamBuilder] and
/// pass the current list snapshot.
///
/// The generic [buildItemCard] callback gives callers full control over
/// each row's presentation.
class DsSelectedItemsSheet<T> extends StatelessWidget {
  const DsSelectedItemsSheet({
    super.key,
    required this.items,
    required this.onRemoveItem,
    required this.buildItemCard,
    this.title,
  });

  final List<T> items;
  final void Function(T item) onRemoveItem;
  final Widget Function(T item, bool isLast) buildItemCard;

  /// Override for the header count label. When null, defaults to
  /// "N selected".
  final String? title;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.72),
      decoration: BoxDecoration(
        color: c.surfaceRaised,
        borderRadius: BorderRadius.only(
          topLeft: AppRadius.round.topLeft,
          topRight: AppRadius.round.topRight,
        ),
        boxShadow: AppShadows.highLight,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle bar ─────────────────────────────────────────
          Container(
            width: 44.w,
            height: 4.h,
            margin:
                EdgeInsets.only(top: AppSpacing.sm.h, bottom: AppSpacing.xs.h),
            decoration: BoxDecoration(
              color: c.divider,
              borderRadius: AppRadius.circle,
            ),
          ),

          // ── Header ─────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenPadding.w,
              AppSpacing.sm.h,
              AppSpacing.screenPadding.w,
              AppSpacing.md.h,
            ),
            child: Row(
              children: [
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: c.accentMuted,
                    borderRadius: AppRadius.circle,
                  ),
                  child: Icon(
                    LucideIcons.userRoundCheck,
                    size: 14.w,
                    color: c.accent,
                  ),
                ),
                SizedBox(width: AppSpacing.sm.w),
                Expanded(
                  child: Text(
                    title ?? '${items.length} selected',
                    style: AppTextStyles.subheading.copyWith(
                      color: c.contentPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // ── List ───────────────────────────────────────────────
          Flexible(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                AppSpacing.screenPadding.w,
                0,
                AppSpacing.screenPadding.w,
                AppSpacing.screenPadding.h,
              ),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: AppRadius.soft,
                border: Border.all(color: c.divider, width: 0.5),
              ),
              child: ClipRRect(
                borderRadius: AppRadius.soft,
                child: ListView.builder(
                  itemCount: items.length,
                  primary: false,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xs.h),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => buildItemCard(
                    items[index],
                    index == items.length - 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Standard item card row for [DsSelectedItemsSheet].
///
/// Shows a circle avatar (image or initials) with a name label and an
/// ×-button on the trailing edge.
class DsSelectedItemCard extends StatelessWidget {
  const DsSelectedItemCard({
    super.key,
    required this.name,
    required this.onRemove,
    this.avatarUrl,
    this.isLast = false,
  });

  final String name;
  final VoidCallback onRemove;
  final String? avatarUrl;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md.w,
            vertical: AppSpacing.sm.h,
          ),
          child: Row(
            children: [
              DsAvatar(
                name: name,
                faceUrl: (avatarUrl?.isNotEmpty ?? false) ? avatarUrl : null,
                size: 36,
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: c.contentPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: c.surfaceOverlay,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.x,
                    size: 12.w,
                    color: c.contentSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Padding(
            padding: EdgeInsets.only(left: (AppSpacing.md * 2 + 36).w),
            child: Divider(height: 1, thickness: 0.5, color: c.divider),
          ),
      ],
    );
  }
}
