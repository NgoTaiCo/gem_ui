import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/shadows.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Labels
// ─────────────────────────────────────────────────────────────────────────────

/// Localization strings for [showDsMuteSheet].
///
/// All fields default to English. Pass a custom instance to localize.
class DsMuteLabels {
  const DsMuteLabels({
    this.title = 'Set Mute',
    this.unmute = 'Unmute',
    this.tenMinutes = '10 minutes',
    this.oneHour = '1 hour',
    this.twelveHours = '12 hours',
    this.oneDay = '1 day',
    this.custom = 'Custom',
    this.cancel = 'Cancel',
    this.confirm = 'Confirm',
  });

  final String title;
  final String unmute;
  final String tenMinutes;
  final String oneHour;
  final String twelveHours;
  final String oneDay;
  final String custom;
  final String cancel;
  final String confirm;
}

// ─────────────────────────────────────────────────────────────────────────────
// Public API
// ─────────────────────────────────────────────────────────────────────────────

/// Shows the mute-duration bottom sheet.
///
/// Returns the selected duration in **seconds**, or `null` if the user
/// cancels. Returns `0` seconds when "Unmute" is selected.
///
/// ```dart
/// final seconds = await showDsMuteSheet(
///   context: context,
///   currentlyMuted: true,
///   labels: DsMuteLabels(title: StrRes.setMute, ...),
/// );
/// ```
Future<int?> showDsMuteSheet({
  required BuildContext context,
  bool currentlyMuted = false,
  int? currentMuteEndTime,
  DsMuteLabels labels = const DsMuteLabels(),
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _DsMuteSheetBody(
      currentlyMuted: currentlyMuted,
      currentMuteEndTime: currentMuteEndTime,
      labels: labels,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sheet body
// ─────────────────────────────────────────────────────────────────────────────

const double _kIconSize = 20.0;
const double _kRowVertical = 14.0;

class _DsMuteSheetBody extends StatefulWidget {
  const _DsMuteSheetBody({
    required this.currentlyMuted,
    required this.labels,
    this.currentMuteEndTime,
  });

  final bool currentlyMuted;
  final int? currentMuteEndTime;
  final DsMuteLabels labels;

  @override
  State<_DsMuteSheetBody> createState() => _DsMuteSheetBodyState();
}

class _DsMuteSheetBodyState extends State<_DsMuteSheetBody> {
  /// 0 = Unmute, 1-4 = presets, 10 = custom
  int _selectedIndex = 10;

  DateTime? _customDateTime;

  @override
  void initState() {
    super.initState();
    if (widget.currentlyMuted && widget.currentMuteEndTime != null) {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final endSecs = widget.currentMuteEndTime! > 10000000000
          ? widget.currentMuteEndTime! ~/ 1000
          : widget.currentMuteEndTime!;
      final remaining = endSecs - now;
      if (remaining > 0) {
        if (remaining >= 9 * 60 && remaining <= 11 * 60) {
          _selectedIndex = 1;
        } else if (remaining >= 59 * 60 && remaining <= 61 * 60) {
          _selectedIndex = 2;
        } else if (remaining >= 11 * 60 * 60 && remaining <= 13 * 60 * 60) {
          _selectedIndex = 3;
        } else if (remaining >= 23 * 60 * 60 && remaining <= 25 * 60 * 60) {
          _selectedIndex = 4;
        } else {
          _customDateTime = DateTime.fromMillisecondsSinceEpoch(endSecs * 1000);
          _selectedIndex = 10;
        }
      } else {
        _selectedIndex = 0;
      }
    } else {
      _selectedIndex = widget.currentlyMuted ? 10 : 0;
    }
  }

  void _selectIndex(int index) => setState(() {
        _selectedIndex = index;
        _customDateTime = null;
      });

  Future<void> _openCustomPicker() async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(minutes: 1));

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _customDateTime ?? firstDate,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (pickedDate == null) return;
    if (!mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _customDateTime != null
          ? TimeOfDay.fromDateTime(_customDateTime!)
          : TimeOfDay.fromDateTime(firstDate),
    );
    if (pickedTime == null) return;

    final combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    if (combined.isAfter(now)) {
      setState(() {
        _customDateTime = combined;
        _selectedIndex = 10;
      });
    }
  }

  void _onConfirm() {
    int seconds = 0;
    if (_selectedIndex < 5) {
      const durations = [0, 10 * 60, 60 * 60, 12 * 60 * 60, 24 * 60 * 60];
      seconds = durations[_selectedIndex];
    } else if (_selectedIndex == 10 && _customDateTime != null) {
      final delta = _customDateTime!.difference(DateTime.now()).inSeconds;
      if (delta > 0) seconds = delta;
    }
    Navigator.of(context).pop(seconds);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final l = widget.labels;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.sm.w,
          AppSpacing.xl.h,
          AppSpacing.sm.w,
          AppSpacing.sm.h,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: c.surfaceRaised,
            borderRadius: AppRadius.soft,
            border: Border.all(color: c.divider),
            boxShadow: AppShadows.highLight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Drag handle + title
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.md.w,
                  AppSpacing.sm.h,
                  AppSpacing.md.w,
                  AppSpacing.sm.h,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: c.divider,
                          borderRadius: AppRadius.circle,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm.h),
                    Text(
                      l.title,
                      style: AppTextStyles.subheading
                          .copyWith(color: c.contentPrimary),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 1, color: c.divider),

              // ── Option rows
              _buildOptionRow(c, LucideIcons.volumeX, l.unmute, 0,
                  isUnmute: true),
              _buildInsetDivider(c),
              _buildOptionRow(c, LucideIcons.clock3, l.tenMinutes, 1),
              _buildInsetDivider(c),
              _buildOptionRow(c, LucideIcons.clock9, l.oneHour, 2),
              _buildInsetDivider(c),
              _buildOptionRow(c, LucideIcons.clock12, l.twelveHours, 3),
              _buildInsetDivider(c),
              _buildOptionRow(c, LucideIcons.calendar, l.oneDay, 4),
              _buildInsetDivider(c),
              _buildCustomRow(c, l.custom),

              Divider(height: 1, thickness: 1, color: c.divider),

              // ── Cancel / Confirm
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.md.w,
                  AppSpacing.sm.h,
                  AppSpacing.md.w,
                  AppSpacing.sm.h,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: l.cancel,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm.w),
                    Expanded(
                      child: _ActionButton(
                        label: l.confirm,
                        onTap: _onConfirm,
                        isPrimary: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionRow(
    AppColorTokens c,
    IconData icon,
    String title,
    int index, {
    bool isUnmute = false,
  }) {
    final isSelected = _selectedIndex == index;
    final activeColor = isUnmute ? c.stateSuccess : c.accent;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _selectIndex(index),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md.w,
            vertical: _kRowVertical.h,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: _kIconSize.w,
                color: isSelected ? activeColor : c.contentSecondary,
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? activeColor : c.contentPrimary,
                  ),
                ),
              ),
              if (isSelected)
                Icon(LucideIcons.check, size: _kIconSize.w, color: activeColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomRow(AppColorTokens c, String customLabel) {
    final isSelected = _selectedIndex == 10;
    final activeColor = c.accent;
    final label = _customDateTime != null
        ? DateFormat('dd/MM/yyyy HH:mm').format(_customDateTime!)
        : null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openCustomPicker,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md.w,
            vertical: _kRowVertical.h,
          ),
          child: Row(
            children: [
              Icon(
                LucideIcons.calendarClock,
                size: _kIconSize.w,
                color: isSelected ? activeColor : c.contentSecondary,
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Text(
                  customLabel,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? activeColor : c.contentPrimary,
                  ),
                ),
              ),
              if (label != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm.w,
                    vertical: AppSpacing.xs.h,
                  ),
                  decoration: BoxDecoration(
                    color: c.accentMuted,
                    borderRadius: AppRadius.sharp,
                  ),
                  child: Text(
                    label,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: c.accent,
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.xs.w),
                Icon(LucideIcons.check, size: _kIconSize.w, color: activeColor),
              ] else
                Icon(
                  LucideIcons.chevronRight,
                  size: _kIconSize.w,
                  color: c.contentSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInsetDivider(AppColorTokens c) {
    return Padding(
      padding: EdgeInsets.only(
        left: (AppSpacing.md + _kIconSize + AppSpacing.md).w,
      ),
      child: Divider(height: 1, thickness: 1, color: c.divider),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private action button
// ─────────────────────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    return Material(
      color: isPrimary ? c.accent : c.surface,
      borderRadius: AppRadius.soft,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.soft,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm.h + 2.h),
          decoration: BoxDecoration(
            borderRadius: AppRadius.soft,
            border: Border.all(color: c.divider),
          ),
          child: Text(
            label,
            style: AppTextStyles.subheading.copyWith(
              color: isPrimary ? c.onAccent : c.contentSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
