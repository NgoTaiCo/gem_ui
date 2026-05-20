import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PrimitivesPage extends StatelessWidget {
  const PrimitivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Scaffold(
      appBar: DsAppBar(title: 'Primitives'),
      backgroundColor: c.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.screenPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel(context, 'Avatars'),
            SizedBox(height: AppSpacing.sm.h),
            Wrap(
              spacing: AppSpacing.md.w,
              runSpacing: AppSpacing.sm.h,
              children: [
                DsAvatar(name: 'John Doe', size: 40),
                DsAvatar(name: 'Alice', faceUrl: '', size: 40),
                DsAvatar(name: 'G', isGroup: true, size: 40),
                DsAvatar(name: 'Ring', size: 48, showRing: true),
              ],
            ),
            SizedBox(height: AppSpacing.lg.h),
            _sectionLabel(context, 'Buttons'),
            SizedBox(height: AppSpacing.sm.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DsButton.primary(label: 'Primary Button', onPressed: () {}),
                SizedBox(height: AppSpacing.sm.h),
                DsButton.secondary(label: 'Secondary Button', onPressed: () {}),
                SizedBox(height: AppSpacing.sm.h),
                DsButton.destructive(label: 'Delete', onPressed: () {}),
                SizedBox(height: AppSpacing.sm.h),
                DsButton.text(
                  label: 'Text Button',
                  icon: Icon(LucideIcons.plus, size: 16.w, color: c.accent),
                  onPressed: () {},
                ),
                SizedBox(height: AppSpacing.sm.h),
                DsButton.primary(label: 'Loading...', isLoading: true),
                SizedBox(height: AppSpacing.sm.h),
                DsButton.primary(label: 'Disabled'),
              ],
            ),
            SizedBox(height: AppSpacing.lg.h),
            _sectionLabel(context, 'Labels'),
            SizedBox(height: AppSpacing.sm.h),
            Wrap(
              spacing: AppSpacing.sm.w,
              children: [
                const DsLabel(text: 'Default'),
                DsLabel(
                  text: 'Warning',
                  backgroundColor: c.stateWarning.withValues(alpha: 0.15),
                  textColor: c.stateWarning,
                ),
                DsLabel(
                  text: 'Error',
                  backgroundColor: c.stateError.withValues(alpha: 0.12),
                  textColor: c.stateError,
                ),
                DsLabel(
                  text: 'Success',
                  backgroundColor: c.stateSuccess.withValues(alpha: 0.12),
                  textColor: c.stateSuccess,
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg.h),
            _sectionLabel(context, 'Empty & Loading States'),
            SizedBox(height: AppSpacing.sm.h),
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: c.surfaceRaised,
                borderRadius: AppRadius.soft,
                border: Border.all(color: c.divider),
              ),
              child: DsEmptyState(
                icon: Icon(LucideIcons.inbox,
                    size: 40.w, color: c.contentSecondary),
                title: 'No results found',
                subtitle: 'Try a different search term',
                action: DsButton.secondary(
                  label: 'Clear Search',
                  onPressed: () {},
                  width: 140.w,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.md.h),
            Container(
              height: 80.h,
              decoration: BoxDecoration(
                color: c.surfaceRaised,
                borderRadius: AppRadius.soft,
                border: Border.all(color: c.divider),
              ),
              child: const DsLoadingSpinner(label: 'Loading...'),
            ),
            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String text) {
    final c = context.colorTokens;
    return Text(
      text.toUpperCase(),
      style: AppTextStyles.caption.copyWith(
        color: c.contentSecondary,
        letterSpacing: 1.2,
      ),
    );
  }
}
