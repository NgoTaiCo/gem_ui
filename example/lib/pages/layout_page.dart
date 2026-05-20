import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Scaffold(
      backgroundColor: c.surface,
      body: Column(
        children: [
          DsDashboardHeader(
            title: 'Dashboard Header',
            leading: const DsAvatar(name: 'Me', size: 36),
            action: Icon(LucideIcons.bell, size: 22.w, color: c.contentPrimary),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
              child: Column(
                children: [
                  DsSectionCard(
                    title: 'Profile',
                    children: [
                      DsFlatRow(
                        icon: LucideIcons.user,
                        label: 'Edit Profile',
                        onTap: () {},
                      ),
                      DsFlatRow(
                        icon: LucideIcons.bell,
                        label: 'Notifications',
                        onTap: () {},
                        showDivider: false,
                      ),
                    ],
                  ),
                  DsSectionCard(
                    title: 'Account',
                    children: [
                      DsFlatRow(
                        icon: LucideIcons.lock,
                        label: 'Change Password',
                        subtitle: 'Last changed 30 days ago',
                        onTap: () {},
                      ),
                      DsFlatRow(
                        icon: LucideIcons.trash2,
                        label: 'Delete Account',
                        iconColor: c.stateError,
                        onTap: () {},
                        showDivider: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
