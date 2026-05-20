import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Plain data struct for [DsMerchantItem].
/// Decouples from the Merchant SDK model and removes DataSp dependency.
/// [displayInviteCode] is pre-resolved by the caller.
class DsMerchantItemData {
  final String id;
  final String inviteCode;

  /// Pre-resolved display label: invite code if present,
  /// otherwise saved invite code, otherwise company-id fallback.
  final String displayInviteCode;

  const DsMerchantItemData({
    required this.id,
    required this.inviteCode,
    required this.displayInviteCode,
  });
}

/// Tokenized merchant / company list card.
class DsMerchantItem extends StatelessWidget {
  const DsMerchantItem({
    super.key,
    required this.data,
    this.isCurrent = false,
    required this.onBtnTap,
    required this.btnLabel,
    this.isDefault = false,
    this.isExist = false,
    this.avatarAsset = 'assets/images/app-icon.png',
    this.currentLabel = 'Current',
    this.inviteCodeLabel = 'Invite Code',
    this.companyIdLabel = 'Company ID',
  });

  final DsMerchantItemData data;
  final bool isCurrent;
  final VoidCallback? onBtnTap;
  final String btnLabel;
  final bool isDefault;
  final bool isExist;

  /// Asset path for the company avatar/icon image.
  final String avatarAsset;

  // Localised string labels — callers pass StrRes values.
  final String currentLabel;
  final String inviteCodeLabel;
  final String companyIdLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadius.soft,
        onTap: onBtnTap,
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAvatar(c),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(child: _buildCompanyInfo(c)),
                ],
              ),
              SizedBox(height: AppSpacing.md.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isCurrent) _buildCurrentBadge(c),
                  if (isCurrent) SizedBox(width: 12.w),
                  _buildOperationButton(c),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(AppColorTokens c) {
    Widget fallback() {
      return Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: c.accentMuted,
          borderRadius: AppRadius.soft,
        ),
        child: Icon(
          CupertinoIcons.building_2_fill,
          size: 24.w,
          color: c.accent,
        ),
      );
    }

    return Image.asset(
      avatarAsset,
      width: 48.w,
      height: 48.w,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => fallback(),
    );
  }

  Widget _buildCompanyInfo(AppColorTokens c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$inviteCodeLabel: ${data.displayInviteCode}',
          style: AppTextStyles.subheading.copyWith(color: c.contentPrimary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        AppSpacing.xs.verticalSpace,
        Text(
          '$companyIdLabel: ${data.id}',
          style: AppTextStyles.caption.copyWith(color: c.contentSecondary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCurrentBadge(AppColorTokens c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: c.accentMuted,
        borderRadius: AppRadius.sharp,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.star_fill, size: 12.w, color: c.accent),
          AppSpacing.xs.horizontalSpace,
          Text(
            currentLabel,
            style: AppTextStyles.label.copyWith(color: c.accent),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationButton(AppColorTokens c) {
    return GestureDetector(
      onTap: onBtnTap,
      child: Container(
        height: 36.h,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
        decoration: BoxDecoration(
          color: isExist ? c.disabled : c.accent,
          borderRadius: AppRadius.soft,
        ),
        child: Center(
          child: Text(
            btnLabel,
            style: AppTextStyles.label.copyWith(color: c.onAccent),
          ),
        ),
      ),
    );
  }
}
