import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/typography.dart';

/// Unified circular avatar component.
///
/// Priority: network image → initials → icon fallback.
/// Use [showRing] for a 2dp [divider]-coloured ring (e.g. on card surfaces).
class DsAvatar extends StatelessWidget {
  const DsAvatar({
    super.key,
    required this.name,
    this.faceUrl,
    this.size = 48,
    this.isGroup = false,
    this.showRing = false,
  });

  final String name;
  final String? faceUrl;
  final double size;
  final bool isGroup;
  final bool showRing;

  String get _initials {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return trimmed[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    Widget avatar;

    if (faceUrl != null && faceUrl!.isNotEmpty) {
      avatar = ExtendedImage.network(
        faceUrl!,
        width: size.w,
        height: size.w,
        fit: BoxFit.cover,
        shape: BoxShape.circle,
        borderRadius: AppRadius.circle,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.failed:
              return _buildFallback(c);
            default:
              return null;
          }
        },
      );
    } else {
      avatar = _buildFallback(c);
    }

    if (!showRing) {
      return SizedBox(width: size.w, height: size.w, child: avatar);
    }

    return Container(
      width: (size + 4).w,
      height: (size + 4).w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: c.divider, width: 2),
      ),
      child: ClipOval(child: avatar),
    );
  }

  Widget _buildFallback(AppColorTokens c) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: c.accent,
        borderRadius: AppRadius.circle,
      ),
      child: Center(
        child: isGroup
            ? Icon(LucideIcons.users, size: size * 0.45, color: c.onAccent)
            : Text(
                _initials,
                style: AppTextStyles.label.copyWith(
                  color: c.onAccent,
                  fontSize: size * 0.35,
                ),
              ),
      ),
    );
  }
}
