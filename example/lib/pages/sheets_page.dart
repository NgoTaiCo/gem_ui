import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';

class SheetsPage extends StatelessWidget {
  const SheetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Scaffold(
      appBar: DsAppBar(title: 'Sheets'),
      backgroundColor: c.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.screenPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DsButton.secondary(
              label: 'Set Remark Sheet',
              onPressed: () => showDsSetRemarkSheet(
                context,
                initialRemark: 'John',
                onSave: (v) {},
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            DsButton.secondary(
              label: 'Font Size Sheet',
              onPressed: () => showDsFontSizeSheet(
                context,
                fontSize: 14,
                onConfirm: (size) {},
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            DsButton.secondary(
              label: 'Chat Background Sheet',
              onPressed: () => showDsChatBackgroundSheet(
                context,
                onPickFromAlbum: () {},
                onPickFromCamera: () {},
                onResetDefault: () {},
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            DsButton.secondary(
              label: 'QR Code Sheet',
              onPressed: () => showDsQrSheet(
                context,
                data: 'https://gem.chat/user/10001234',
                title: 'Share Profile',
                subtitle: 'Scan to add me',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
