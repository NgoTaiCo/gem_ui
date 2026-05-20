import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Tokenized filled search / input field with built-in clear affordance.
///
/// For non-interactive (tap-to-navigate) bars, wrap in a [GestureDetector]
/// with `onTap` and set `enabled: false`.
class DsSearchField extends StatelessWidget {
  const DsSearchField({
    super.key,
    required this.controller,
    this.focusNode,
    this.hintText = 'Search',
    this.autofocus = false,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.leading,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool autofocus;
  final bool enabled;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: c.inputFill,
        borderRadius: AppRadius.soft,
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        enabled: enabled,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppTextStyles.body.copyWith(color: c.contentPrimary),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.body.copyWith(color: c.contentSecondary),
          prefixIcon: leading ??
              Icon(
                Icons.search_rounded,
                size: 20.w,
                color: c.contentSecondary,
              ),
          suffixIcon: ValueListenableBuilder(
            valueListenable: controller,
            builder: (_, value, __) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return GestureDetector(
                onTap: () {
                  controller.clear();
                  onClear?.call();
                  onChanged?.call('');
                },
                child: Icon(Icons.close_rounded,
                    size: 18.w, color: c.contentSecondary),
              );
            },
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm.w,
            vertical: AppSpacing.xs.h,
          ),
          isDense: true,
        ),
      ),
    );
  }
}
