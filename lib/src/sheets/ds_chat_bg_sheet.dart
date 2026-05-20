import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Shows the [DsChatBackgroundSheet].
Future<void> showDsChatBackgroundSheet(
  BuildContext context, {
  required VoidCallback onPickFromAlbum,
  required VoidCallback onPickFromCamera,
  required VoidCallback onResetDefault,
  String titleLabel = 'Chat Background',
  String albumLabel = 'Choose from Album',
  String cameraLabel = 'Take Photo',
  String resetLabel = 'Reset to Default',
  String cancelLabel = 'Cancel',
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DsChatBackgroundSheet(
      onPickFromAlbum: onPickFromAlbum,
      onPickFromCamera: onPickFromCamera,
      onResetDefault: onResetDefault,
      titleLabel: titleLabel,
      albumLabel: albumLabel,
      cameraLabel: cameraLabel,
      resetLabel: resetLabel,
      cancelLabel: cancelLabel,
    ),
  );
}

/// Tokenized chat-background action sheet.
class DsChatBackgroundSheet extends StatelessWidget {
  const DsChatBackgroundSheet({
    super.key,
    required this.onPickFromAlbum,
    required this.onPickFromCamera,
    required this.onResetDefault,
    this.titleLabel = 'Chat Background',
    this.albumLabel = 'Choose from Album',
    this.cameraLabel = 'Take Photo',
    this.resetLabel = 'Reset to Default',
    this.cancelLabel = 'Cancel',
  });

  final VoidCallback onPickFromAlbum;
  final VoidCallback onPickFromCamera;
  final VoidCallback onResetDefault;
  final String titleLabel;
  final String albumLabel;
  final String cameraLabel;
  final String resetLabel;
  final String cancelLabel;

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
                child: Icon(LucideIcons.image, size: 22.w, color: c.accent),
              ),
              SizedBox(height: AppSpacing.sm.h),
              Text(
                titleLabel,
                style:
                    AppTextStyles.subheading.copyWith(color: c.contentPrimary),
              ),
              SizedBox(height: AppSpacing.md.h),
              // Options
              _buildOption(
                  context, c, LucideIcons.image, albumLabel, onPickFromAlbum),
              Divider(
                  height: 1,
                  thickness: 1,
                  color: c.divider,
                  indent: AppSpacing.md.w),
              _buildOption(context, c, LucideIcons.camera, cameraLabel,
                  onPickFromCamera),
              Divider(
                  height: 1,
                  thickness: 1,
                  color: c.divider,
                  indent: AppSpacing.md.w),
              _buildOption(context, c, LucideIcons.refreshCcw, resetLabel,
                  onResetDefault,
                  isDestructive: true),
              Divider(height: 8, thickness: 8, color: c.surfaceOverlay),
              // Cancel
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: Center(
                      child: Text(
                        cancelLabel,
                        style: AppTextStyles.subheading
                            .copyWith(color: c.contentSecondary),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xs.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    AppColorTokens c,
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final color = isDestructive ? c.stateError : c.contentPrimary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md.w,
            vertical: AppSpacing.md.h - 2.h,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20.w, color: color),
              SizedBox(width: AppSpacing.md.w),
              Text(
                label,
                style: AppTextStyles.body.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
