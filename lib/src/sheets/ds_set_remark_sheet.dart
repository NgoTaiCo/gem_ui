import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Shows the [DsSetRemarkSheet].
///
/// Calls [onSave] with the trimmed remark when the user confirms.
Future<void> showDsSetRemarkSheet(
  BuildContext context, {
  required String initialRemark,
  required void Function(String remark) onSave,
  String title = 'Set Remark',
  String hintText = 'Enter remark',
  String cancelLabel = 'Cancel',
  String confirmLabel = 'Save',
  int maxLength = 20,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DsSetRemarkSheet(
      initialRemark: initialRemark,
      onSave: onSave,
      title: title,
      hintText: hintText,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
      maxLength: maxLength,
    ),
  );
}

/// Tokenized remark-edit bottom sheet.
class DsSetRemarkSheet extends StatefulWidget {
  const DsSetRemarkSheet({
    super.key,
    required this.initialRemark,
    required this.onSave,
    this.title = 'Set Remark',
    this.hintText = 'Enter remark',
    this.cancelLabel = 'Cancel',
    this.confirmLabel = 'Save',
    this.maxLength = 20,
  });

  final String initialRemark;
  final void Function(String remark) onSave;
  final String title;
  final String hintText;
  final String cancelLabel;
  final String confirmLabel;
  final int maxLength;

  @override
  State<DsSetRemarkSheet> createState() => _DsSetRemarkSheetState();
}

class _DsSetRemarkSheetState extends State<DsSetRemarkSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialRemark);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final mq = MediaQuery.of(context);
    final pad = mq.viewInsets.bottom;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Container(
        padding: EdgeInsets.only(bottom: pad),
        decoration: BoxDecoration(
          color: c.surfaceRaised,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: AppSpacing.sm.h),
                // Drag handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: c.divider,
                    borderRadius: AppRadius.circle,
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                // Title
                Text(
                  widget.title,
                  style: AppTextStyles.subheading
                      .copyWith(color: c.contentPrimary),
                ),
                SizedBox(height: AppSpacing.md.h),
                // Input + counter
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: _controller,
                      maxLength: widget.maxLength,
                      autofocus: true,
                      style:
                          AppTextStyles.body.copyWith(color: c.contentPrimary),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: widget.hintText,
                        hintStyle: AppTextStyles.body
                            .copyWith(color: c.contentSecondary),
                        filled: true,
                        fillColor: c.inputFill,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md.w,
                          vertical: AppSpacing.sm.h,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: AppRadius.soft,
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: AppRadius.soft,
                          borderSide: BorderSide(color: c.accent, width: 1.5),
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    Positioned(
                      right: AppSpacing.sm.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs.w + 2,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: c.surfaceOverlay,
                          borderRadius: AppRadius.sharp,
                        ),
                        child: Text(
                          '${_controller.text.length}/${widget.maxLength}',
                          style: AppTextStyles.caption
                              .copyWith(color: c.contentSecondary),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md.h),
                // CTA row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: c.contentSecondary,
                          side: BorderSide(color: c.divider),
                          shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.soft),
                          padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.sm.h + 2.h),
                        ),
                        child: Text(
                          widget.cancelLabel,
                          style: AppTextStyles.subheading
                              .copyWith(color: c.contentSecondary),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onSave(_controller.text.trim());
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c.accent,
                          foregroundColor: c.onAccent,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.soft),
                          padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.sm.h + 2.h),
                        ),
                        child: Text(
                          widget.confirmLabel,
                          style: AppTextStyles.subheading
                              .copyWith(color: c.onAccent),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
