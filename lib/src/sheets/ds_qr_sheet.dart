import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Shows the [DsQrSheet].
Future<void> showDsQrSheet(
  BuildContext context, {
  required String data,
  String? title,
  String? subtitle,
  String? avatarUrl,
  String closeLabel = 'Close',
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DsQrSheet(
      data: data,
      title: title,
      subtitle: subtitle,
      avatarUrl: avatarUrl,
      closeLabel: closeLabel,
    ),
  );
}

/// Tokenized QR-code bottom sheet.
class DsQrSheet extends StatelessWidget {
  const DsQrSheet({
    super.key,
    required this.data,
    this.title,
    this.subtitle,
    this.avatarUrl,
    this.closeLabel = 'Close',
  });

  final String data;
  final String? title;
  final String? subtitle;
  final String? avatarUrl;
  final String closeLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Container(
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
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: c.divider,
                    borderRadius: AppRadius.circle,
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: c.accentMuted,
                    borderRadius: AppRadius.soft,
                  ),
                  child: Icon(LucideIcons.qrCode, size: 22.w, color: c.accent),
                ),
                SizedBox(height: AppSpacing.sm.h),
                if (title != null)
                  Text(
                    title!,
                    style: AppTextStyles.subheading
                        .copyWith(color: c.contentPrimary),
                  ),
                if (subtitle != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle!,
                    style: AppTextStyles.caption
                        .copyWith(color: c.contentSecondary),
                  ),
                ],
                SizedBox(height: AppSpacing.lg.h),
                Container(
                  padding: EdgeInsets.all(AppSpacing.md.w),
                  decoration: BoxDecoration(
                    color: c.surface,
                    borderRadius: AppRadius.soft,
                    border: Border.all(color: c.divider),
                  ),
                  child: QrImageView(
                    data: data,
                    version: QrVersions.auto,
                    size: 200.w,
                    eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: c.contentPrimary,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: c.contentPrimary,
                    ),
                    backgroundColor: c.surface,
                  ),
                ),
                SizedBox(height: AppSpacing.lg.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c.accent,
                      foregroundColor: c.onAccent,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: AppRadius.soft),
                      padding:
                          EdgeInsets.symmetric(vertical: AppSpacing.sm.h + 2.h),
                    ),
                    child: Text(
                      closeLabel,
                      style:
                          AppTextStyles.subheading.copyWith(color: c.onAccent),
                    ),
                  ),
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
