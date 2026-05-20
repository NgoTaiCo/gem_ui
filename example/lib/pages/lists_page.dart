import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  bool _notifications = true;
  bool _sounds = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Scaffold(
      appBar: DsAppBar(title: 'Lists'),
      backgroundColor: c.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
        child: Column(
          children: [
            DsMenuSection(
              title: 'Chat',
              children: [
                DsMenuItemSwitch(
                  title: 'Notifications',
                  value: _notifications,
                  onChanged: (v) => setState(() => _notifications = v),
                  leadingIcon: LucideIcons.bell,
                ),
                DsMenuItemSwitch(
                  title: 'Sounds',
                  value: _sounds,
                  onChanged: (v) => setState(() => _sounds = v),
                  leadingIcon: LucideIcons.volume2,
                ),
              ],
            ),
            DsMenuSection(
              title: 'Profile',
              children: [
                DsMenuItemValue(
                  title: 'Language',
                  value: 'English',
                  leadingIcon: LucideIcons.globe,
                  onTap: () {},
                ),
                DsMenuItemValue(
                  title: 'Theme',
                  value: 'Light',
                  leadingIcon: LucideIcons.sun,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}
