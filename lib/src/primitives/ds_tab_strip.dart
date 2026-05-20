import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// A single tab chip in a [DsTabStrip].
class DsTabItem {
  const DsTabItem({required this.label});
  final String label;
}

/// Horizontal chip-style tab strip using plain [int] for active state —
/// no GetX dependency.
///
/// Renders each tab as a pill chip: accent-tinted when active,
/// [surfaceOverlay] when inactive.
class DsTabStrip extends StatelessWidget {
  const DsTabStrip({
    super.key,
    required this.tabs,
    required this.activeIndex,
    required this.onTap,
    this.padding,
  });

  final List<DsTabItem> tabs;
  final int activeIndex;
  final ValueChanged<int> onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(
        children: List.generate(tabs.length, (i) {
          return _DsTabChip(
            label: tabs[i].label,
            isActive: activeIndex == i,
            onTap: () => onTap(i),
          );
        }),
      ),
    );
  }
}

class _DsTabChip extends StatelessWidget {
  const _DsTabChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.xs.h,
        ),
        decoration: BoxDecoration(
          color: isActive ? c.accentMuted : c.surfaceOverlay,
          borderRadius: AppRadius.sharp,
        ),
        child: Text(
          label,
          style: AppTextStyles.label.copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? c.accent : c.contentSecondary,
          ),
        ),
      ),
    );
  }
}
