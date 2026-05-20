import 'package:flutter/material.dart';

/// GEM colour token system — the single source of truth for brand identity.
///
/// To reskin for a new product, edit the private constants at the top of
/// [AppColorTokens.light()] and publish a new package version.
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  const AppColorTokens({
    required this.surface,
    required this.surfaceRaised,
    required this.surfaceOverlay,
    required this.contentPrimary,
    required this.contentSecondary,
    required this.divider,
    required this.accent,
    required this.accentMuted,
    required this.onAccent,
    required this.bubbleSent,
    required this.bubbleReceived,
    required this.onBubbleSent,
    required this.onBubbleReceived,
    required this.presenceOnline,
    required this.unreadCount,
    required this.stateError,
    required this.stateSuccess,
    required this.stateWarning,
    required this.inputFill,
    required this.disabled,
  });

  // ── 60 % Neutral surfaces ────────────────────────────────────────────────
  final Color surface;
  final Color surfaceRaised;
  final Color surfaceOverlay;

  // ── 30 % Content & structure ─────────────────────────────────────────────
  final Color contentPrimary;
  final Color contentSecondary;
  final Color divider;

  // ── 10 % Accent ───────────────────────────────────────────────────────────
  final Color accent;
  final Color accentMuted;
  final Color onAccent;

  // ── Chat semantic ─────────────────────────────────────────────────────────
  final Color bubbleSent;
  final Color bubbleReceived;
  final Color onBubbleSent;
  final Color onBubbleReceived;
  final Color presenceOnline;
  final Color unreadCount;

  // ── State / utility ───────────────────────────────────────────────────────
  final Color stateError;
  final Color stateSuccess;
  final Color stateWarning;
  final Color inputFill;
  final Color disabled;

  // ── Brand palette ─────────────────────────────────────────────────────────
  // ↓↓↓  Change these to re-brand the entire app  ↓↓↓
  static const Color _accent = Color(0xFF15803D); // green-700
  static const Color _accentMuted = Color(0xFFDCFCE7); // green-100
  static const Color _onAccent = Color(0xFFFFFFFF);
  // ─────────────────────────────────────────────────────────────────────────

  factory AppColorTokens.light() {
    return const AppColorTokens(
      surface: Color(0xFFF8FAFC), // slate-50
      surfaceRaised: Color(0xFFFFFFFF), // white
      surfaceOverlay: Color(0xFFF1F5F9), // slate-100
      contentPrimary: Color(0xFF0F172A), // slate-900
      contentSecondary: Color(0xFF64748B), // slate-500
      divider: Color(0xFFE2E8F0), // slate-200
      accent: _accent,
      accentMuted: _accentMuted,
      onAccent: _onAccent,
      bubbleSent: _accent,
      bubbleReceived: Color(0xFFF1F5F9), // slate-100
      onBubbleSent: _onAccent,
      onBubbleReceived: Color(0xFF0F172A), // slate-900
      presenceOnline: Color(0xFF22C55E), // green-500
      unreadCount: _accent,
      stateError: Color(0xFFEF4444), // red-500
      stateSuccess: Color(0xFF16A34A), // green-600
      stateWarning: Color(0xFFD97706), // amber-600
      inputFill: Color(0xFFF1F5F9), // slate-100
      disabled: Color(0xFF94A3B8), // slate-400
    );
  }

  @override
  AppColorTokens copyWith({
    Color? surface,
    Color? surfaceRaised,
    Color? surfaceOverlay,
    Color? contentPrimary,
    Color? contentSecondary,
    Color? divider,
    Color? accent,
    Color? accentMuted,
    Color? onAccent,
    Color? bubbleSent,
    Color? bubbleReceived,
    Color? onBubbleSent,
    Color? onBubbleReceived,
    Color? presenceOnline,
    Color? unreadCount,
    Color? stateError,
    Color? stateSuccess,
    Color? stateWarning,
    Color? inputFill,
    Color? disabled,
  }) {
    return AppColorTokens(
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      surfaceOverlay: surfaceOverlay ?? this.surfaceOverlay,
      contentPrimary: contentPrimary ?? this.contentPrimary,
      contentSecondary: contentSecondary ?? this.contentSecondary,
      divider: divider ?? this.divider,
      accent: accent ?? this.accent,
      accentMuted: accentMuted ?? this.accentMuted,
      onAccent: onAccent ?? this.onAccent,
      bubbleSent: bubbleSent ?? this.bubbleSent,
      bubbleReceived: bubbleReceived ?? this.bubbleReceived,
      onBubbleSent: onBubbleSent ?? this.onBubbleSent,
      onBubbleReceived: onBubbleReceived ?? this.onBubbleReceived,
      presenceOnline: presenceOnline ?? this.presenceOnline,
      unreadCount: unreadCount ?? this.unreadCount,
      stateError: stateError ?? this.stateError,
      stateSuccess: stateSuccess ?? this.stateSuccess,
      stateWarning: stateWarning ?? this.stateWarning,
      inputFill: inputFill ?? this.inputFill,
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  AppColorTokens lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      surfaceOverlay: Color.lerp(surfaceOverlay, other.surfaceOverlay, t)!,
      contentPrimary: Color.lerp(contentPrimary, other.contentPrimary, t)!,
      contentSecondary:
          Color.lerp(contentSecondary, other.contentSecondary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentMuted: Color.lerp(accentMuted, other.accentMuted, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      bubbleSent: Color.lerp(bubbleSent, other.bubbleSent, t)!,
      bubbleReceived: Color.lerp(bubbleReceived, other.bubbleReceived, t)!,
      onBubbleSent: Color.lerp(onBubbleSent, other.onBubbleSent, t)!,
      onBubbleReceived:
          Color.lerp(onBubbleReceived, other.onBubbleReceived, t)!,
      presenceOnline: Color.lerp(presenceOnline, other.presenceOnline, t)!,
      unreadCount: Color.lerp(unreadCount, other.unreadCount, t)!,
      stateError: Color.lerp(stateError, other.stateError, t)!,
      stateSuccess: Color.lerp(stateSuccess, other.stateSuccess, t)!,
      stateWarning: Color.lerp(stateWarning, other.stateWarning, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
    );
  }
}

/// Convenience extension so any [BuildContext] can access tokens.
extension GemColorTokens on BuildContext {
  AppColorTokens get colorTokens =>
      Theme.of(this).extension<AppColorTokens>() ?? AppColorTokens.light();
}
