import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Scaffold(
      appBar: DsAppBar(title: 'Cards'),
      backgroundColor: c.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding.w),
              child: Text(
                'PERSON CARDS',
                style: AppTextStyles.caption.copyWith(
                  color: c.contentSecondary,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            DsPersonCard(
              name: 'John Doe',
              subtitle: 'ID: 10001234',
              onTap: () {},
            ),
            DsPersonCard(
              name: 'Design Team',
              subtitle: '12 members',
              isGroup: true,
              onTap: () {},
            ),
            SizedBox(height: AppSpacing.lg.h),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding.w),
              child: Text(
                'SETTINGS TILES',
                style: AppTextStyles.caption.copyWith(
                  color: c.contentSecondary,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding.w),
              decoration: BoxDecoration(
                color: c.surfaceRaised,
                borderRadius: AppRadius.soft,
                border: Border.all(color: c.divider),
              ),
              child: Column(
                children: [
                  DsSettingsTile(
                    icon: LucideIcons.bell,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  Divider(height: 1, thickness: 1, color: c.divider),
                  DsSettingsTile(
                    icon: LucideIcons.lock,
                    title: 'Privacy',
                    onTap: () {},
                  ),
                  Divider(height: 1, thickness: 1, color: c.divider),
                  DsSettingsTile(
                    icon: LucideIcons.trash2,
                    title: 'Delete Account',
                    isDestructive: true,
                    onTap: () {},
                  ),
                  Divider(height: 1, thickness: 1, color: c.divider),
                  DsSettingsTile(
                    icon: LucideIcons.wifiOff,
                    title: 'Offline (disabled)',
                    isDisabled: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}
