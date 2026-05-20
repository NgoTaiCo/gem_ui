import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({super.key});

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Scaffold(
      appBar: DsAppBar(title: 'Forms'),
      backgroundColor: c.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.screenPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label(context, 'Search Field'),
            SizedBox(height: AppSpacing.sm.h),
            DsSearchField(
              controller: _searchCtrl,
              hintText: 'Search messages...',
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: AppSpacing.lg.h),
            _label(context, 'OTP / PIN Field (6-digit)'),
            SizedBox(height: AppSpacing.sm.h),
            DsOtpField(
              length: 6,
              onCompleted: (code) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Code: $code')),
              ),
            ),
            SizedBox(height: AppSpacing.lg.h),
            _label(context, 'OTP / PIN Field (4-digit)'),
            SizedBox(height: AppSpacing.sm.h),
            DsOtpField(
              length: 4,
              onCompleted: (code) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('PIN: $code')),
              ),
            ),
            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text) {
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
