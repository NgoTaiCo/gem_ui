import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/shadows.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────────────────────────────────────

/// A single knowledge card entry.
class DsKnowledgeItem {
  const DsKnowledgeItem({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

// ─────────────────────────────────────────────────────────────────────────────
// Widget
// ─────────────────────────────────────────────────────────────────────────────

/// Flip-card knowledge viewer.
///
/// Shows a card with [DsKnowledgeItem.title] on the front (on
/// [surfaceRaised]) and [DsKnowledgeItem.description] on the back (on
/// [accent]).  Tap the card to flip; tap "Next Card" to advance.
///
/// ```dart
/// DsKnowledgeCard(
///   items: const [
///     DsKnowledgeItem(title: 'Q: What is SOLID?', description: 'A set of 5 OOP design principles…'),
///   ],
/// )
/// ```
class DsKnowledgeCard extends StatefulWidget {
  const DsKnowledgeCard({
    super.key,
    required this.items,
    this.flipHintLabel = 'Tap to flip',
    this.nextLabel = 'Next Card',
  });

  final List<DsKnowledgeItem> items;
  final String flipHintLabel;
  final String nextLabel;

  @override
  State<DsKnowledgeCard> createState() => _DsKnowledgeCardState();
}

class _DsKnowledgeCardState extends State<DsKnowledgeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _currentIndex = 0;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.isAnimating) return;
    if (_showFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => _showFront = !_showFront);
  }

  void _nextCard() {
    if (widget.items.length <= 1) return;
    int next;
    do {
      next = math.Random().nextInt(widget.items.length);
    } while (next == _currentIndex && widget.items.length > 1);
    setState(() {
      _currentIndex = next;
      _showFront = true;
    });
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final item = widget.items.isNotEmpty
        ? widget.items[_currentIndex]
        : const DsKnowledgeItem(title: '', description: '');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Progress indicator
        if (widget.items.length > 1)
          Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm.h),
            child: Text(
              '${_currentIndex + 1} / ${widget.items.length}',
              style: AppTextStyles.caption.copyWith(color: c.contentSecondary),
            ),
          ),

        // ── Flip card
        GestureDetector(
          onTap: _flipCard,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              final angle = _animation.value * math.pi;
              final isBack = angle > math.pi / 2;

              // Shadow halfway
              final transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle);

              // When back face comes into view, flip the transform to read
              // correctly
              final displayTransform = isBack
                  ? (Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle - math.pi))
                  : transform;

              final bg = isBack ? c.accent : c.surfaceRaised;
              final textColor = isBack ? c.onAccent : c.contentPrimary;
              final textStyle = isBack
                  ? AppTextStyles.body.copyWith(color: textColor)
                  : AppTextStyles.subheading.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                    );

              final displayText = isBack ? item.description : item.title;
              final flipHint = isBack ? '' : widget.flipHintLabel;

              return Transform(
                transform: displayTransform,
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 200.h,
                  ),
                  padding: EdgeInsets.all(AppSpacing.lg.w),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: AppRadius.soft,
                    border: Border.all(
                      color: isBack ? c.accent : c.divider,
                    ),
                    boxShadow: AppShadows.lowLight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        displayText,
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                      if (flipHint.isNotEmpty) ...[
                        SizedBox(height: AppSpacing.md.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.refreshCcw,
                              size: 12.w,
                              color: c.contentSecondary,
                            ),
                            SizedBox(width: AppSpacing.xs.w),
                            Text(
                              flipHint,
                              style: AppTextStyles.caption
                                  .copyWith(color: c.contentSecondary),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // ── Next card button
        if (widget.items.length > 1)
          Padding(
            padding: EdgeInsets.only(top: AppSpacing.md.h),
            child: Material(
              color: c.surfaceRaised,
              borderRadius: AppRadius.round,
              child: InkWell(
                borderRadius: AppRadius.round,
                onTap: _nextCard,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg.w,
                    vertical: AppSpacing.sm.h + AppSpacing.xs.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.round,
                    border: Border.all(color: c.divider),
                    boxShadow: AppShadows.lowLight,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.shuffle,
                        size: 14.w,
                        color: c.accent,
                      ),
                      SizedBox(width: AppSpacing.xs.w),
                      Text(
                        widget.nextLabel,
                        style: AppTextStyles.label.copyWith(
                          fontWeight: FontWeight.w600,
                          color: c.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
