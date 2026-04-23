// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  CNBPStyleData – a full description of one visual preset
// ─────────────────────────────────────────────────────────────────────────────

/// Holds all the visual properties that define a `CurvedNavigationBarPro`
/// style preset. Every field is optional — `null` means "fall back to the
/// widget's own default so you can keep a preset as a base and tweak only
/// what you need.
///
/// You normally obtain instances through the [CNBPStyles] enum:
///
/// ```dart
/// final data = CNBPStyles.goldenHour.data;
/// // or modify one field:
/// final tweaked = CNBPStyles.goldenHour.data.copyWith(fabRadius: 30);
/// ```
@immutable
class CNBPStyleData {
  const CNBPStyleData({
    this.backgroundColor,
    this.activeColor,
    this.activeIconColor,
    this.inactiveColor,
    this.fabColor,
    this.barHeight,
    this.fabRadius,
    this.fabGap,
    this.fabSink,
    this.notchShoulderRadius,
    this.cornerRadius,
    this.elevation,
    this.shadowColor,
    this.animationDuration,
    this.animationCurve,
    this.activeTextStyle,
    this.inactiveTextStyle,
  });

  final Color? backgroundColor;
  final Color? activeColor;
  final Color? activeIconColor;
  final Color? inactiveColor;
  final Color? fabColor;
  final double? barHeight;
  final double? fabRadius;
  final double? fabGap;
  final double? fabSink;
  final double? notchShoulderRadius;
  final double? cornerRadius;
  final double? elevation;
  final Color? shadowColor;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final TextStyle? activeTextStyle;
  final TextStyle? inactiveTextStyle;

  /// Returns a copy of this style with the specified fields replaced.
  CNBPStyleData copyWith({
    Color? backgroundColor,
    Color? activeColor,
    Color? activeIconColor,
    Color? inactiveColor,
    Color? fabColor,
    double? barHeight,
    double? fabRadius,
    double? fabGap,
    double? fabSink,
    double? notchShoulderRadius,
    double? cornerRadius,
    double? elevation,
    Color? shadowColor,
    Duration? animationDuration,
    Curve? animationCurve,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
  }) =>
      CNBPStyleData(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        activeColor: activeColor ?? this.activeColor,
        activeIconColor: activeIconColor ?? this.activeIconColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        fabColor: fabColor ?? this.fabColor,
        barHeight: barHeight ?? this.barHeight,
        fabRadius: fabRadius ?? this.fabRadius,
        fabGap: fabGap ?? this.fabGap,
        fabSink: fabSink ?? this.fabSink,
        notchShoulderRadius: notchShoulderRadius ?? this.notchShoulderRadius,
        cornerRadius: cornerRadius ?? this.cornerRadius,
        elevation: elevation ?? this.elevation,
        shadowColor: shadowColor ?? this.shadowColor,
        animationDuration: animationDuration ?? this.animationDuration,
        animationCurve: animationCurve ?? this.animationCurve,
        activeTextStyle: activeTextStyle ?? this.activeTextStyle,
        inactiveTextStyle: inactiveTextStyle ?? this.inactiveTextStyle,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  CNBPStyles – 10 built-in presets
// ─────────────────────────────────────────────────────────────────────────────

/// Ten built-in visual presets for `CurvedNavigationBarPro`.
///
/// Pass a value to the widget's `navbarStyle` parameter to apply a complete
/// look-and-feel in a single line. You can then use any individual parameter
/// to override specific values — explicit parameters always win over the
/// preset:
///
/// ```dart
/// CurvedNavigationBarPro(
///   items: myItems,
///   onTap: (i) => setState(() => _index = i),
///   navbarStyle: CNBPStyles.goldenHour,   // apply preset …
///   fabRadius: 30,                        // … then override one value
/// )
/// ```
enum CNBPStyles {
  /// Clean white bar with an indigo accent — the classic default look.
  classicIndigo,

  /// Dark charcoal bar with a cyan neon accent and a sharp angular notch.
  deepSpaceDark,

  /// White bar with pill-shaped top corners and a warm coral accent.
  roundedCoral,

  /// Flat white bar, fully-sunken FAB, monochrome slate palette.
  minimalMono,

  /// Deep green dark bar, oversized protruding FAB, suited for 5 items.
  emeraldPill,

  /// White bar with a warm amber-orange accent — great for travel apps.
  sunsetAmber,

  /// Deep navy bar with a lavender accent and a large protruding FAB.
  royalAmethyst,

  /// Light steel-grey bar, steel-blue accent, fully-sunk FAB, pill corners.
  arcticFrost,

  /// Very dark bar with a hot-pink accent and ultra-smooth notch shoulders.
  berryBlossom,

  /// Ink-black bar with a pure gold accent — dark icon inside the FAB.
  goldenHour;

  // ─────────────────────────────────────────────────────────────────────────
  //  Preset data
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns the [CNBPStyleData] describing this preset's visual values.
  CNBPStyleData get data {
    switch (this) {
      // ── 1 · Classic Indigo ───────────────────────────────────────────────
      case CNBPStyles.classicIndigo:
        return const CNBPStyleData(
          backgroundColor: Colors.white,
          activeColor: Color(0xFF6C63FF),
          fabColor: Color(0xFF6C63FF),
          activeIconColor: Colors.white,
          inactiveColor: Color(0xFFADB5BD),
          barHeight: 100,
          fabRadius: 24,
          fabGap: 10,
          fabSink: 22,
          notchShoulderRadius: 12,
          cornerRadius: 0,
          elevation: 14,
          shadowColor: Color(0x42000000), // ≈ Colors.black26
          animationDuration: Duration(milliseconds: 400),
          animationCurve: Curves.easeInOutCubic,
        );

      // ── 2 · Deep Space Dark ──────────────────────────────────────────────
      case CNBPStyles.deepSpaceDark:
        return const CNBPStyleData(
          backgroundColor: Color(0xFF1A1A2E),
          activeColor: Color(0xFF00E5FF),
          fabColor: Color(0xFF00E5FF),
          activeIconColor: Color(0xFF0D0D1A),
          inactiveColor: Color(0xFF4A4A6A),
          barHeight: 108,
          fabRadius: 26,
          fabGap: 8,
          fabSink: 26,
          notchShoulderRadius: 0,
          cornerRadius: 0,
          elevation: 20,
          shadowColor: Color(0x3F00E5FF), // cyan 25 % α
          animationDuration: Duration(milliseconds: 350),
          animationCurve: Curves.easeOutBack,
          activeTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: Color(0xFF00E5FF),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
            color: Color(0xFF4A4A6A),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
        );

      // ── 3 · Rounded Coral ────────────────────────────────────────────────
      case CNBPStyles.roundedCoral:
        return const CNBPStyleData(
          backgroundColor: Colors.white,
          activeColor: Color(0xFFFF6B6B),
          fabColor: Color(0xFFFF6B6B),
          activeIconColor: Colors.white,
          inactiveColor: Color(0xFFCCBBBB),
          barHeight: 106,
          fabRadius: 25,
          fabGap: 10,
          fabSink: 20,
          notchShoulderRadius: 20,
          cornerRadius: 28,
          elevation: 10,
          shadowColor: Color(0x33FF6B6B), // coral 20 % α
          animationDuration: Duration(milliseconds: 480),
          animationCurve: Curves.easeInOutSine,
        );

      // ── 4 · Minimal Mono ─────────────────────────────────────────────────
      case CNBPStyles.minimalMono:
        return const CNBPStyleData(
          backgroundColor: Colors.white,
          activeColor: Color(0xFF2D3748),
          fabColor: Color(0xFF2D3748),
          activeIconColor: Colors.white,
          inactiveColor: Color(0xFFCBD5E0),
          barHeight: 96,
          fabRadius: 22,
          fabGap: 6,
          fabSink: 22,
          notchShoulderRadius: 0,
          cornerRadius: 0,
          elevation: 6,
          shadowColor: Color(0x1F000000), // black 12 % α
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeOut,
          activeTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
            color: Color(0xFF2D3748),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFFCBD5E0),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
        );

      // ── 5 · Emerald Pill ─────────────────────────────────────────────────
      case CNBPStyles.emeraldPill:
        return const CNBPStyleData(
          backgroundColor: Color(0xFF0F2D26),
          activeColor: Color(0xFF00C896),
          fabColor: Color(0xFF00C896),
          activeIconColor: Color(0xFF071A14),
          inactiveColor: Color(0xFF2E5448),
          barHeight: 112,
          fabRadius: 30,
          fabGap: 12,
          fabSink: 10,
          notchShoulderRadius: 16,
          cornerRadius: 20,
          elevation: 18,
          shadowColor: Color(0x4C00C896), // emerald 30 % α
          animationDuration: Duration(milliseconds: 500),
          animationCurve: Curves.easeInOutBack,
          activeTextStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: Color(0xFF00C896),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2E5448),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
        );

      // ── 6 · Sunset Amber ─────────────────────────────────────────────────
      case CNBPStyles.sunsetAmber:
        return const CNBPStyleData(
          backgroundColor: Colors.white,
          activeColor: Color(0xFFFF9F43),
          fabColor: Color(0xFFFF9F43),
          activeIconColor: Colors.white,
          inactiveColor: Color(0xFFD4C4B0),
          barHeight: 104,
          fabRadius: 26,
          fabGap: 12,
          fabSink: 18,
          notchShoulderRadius: 18,
          cornerRadius: 0,
          elevation: 12,
          shadowColor: Color(0x2EFF9F43), // amber 18 % α
          animationDuration: Duration(milliseconds: 460),
          animationCurve: Curves.easeInOutSine,
          activeTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: Color(0xFFFF9F43),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFFD4C4B0),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
        );

      // ── 7 · Royal Amethyst ───────────────────────────────────────────────
      case CNBPStyles.royalAmethyst:
        return const CNBPStyleData(
          backgroundColor: Color(0xFF0E0829),
          activeColor: Color(0xFFBE73FF),
          fabColor: Color(0xFFBE73FF),
          activeIconColor: Color(0xFF08051A),
          inactiveColor: Color(0xFF3D2A5C),
          barHeight: 106,
          fabRadius: 28,
          fabGap: 8,
          fabSink: 8,
          notchShoulderRadius: 14,
          cornerRadius: 0,
          elevation: 22,
          shadowColor: Color(0x47BE73FF), // lavender 28 % α
          animationDuration: Duration(milliseconds: 380),
          animationCurve: Curves.easeOutBack,
          activeTextStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
            color: Color(0xFFBE73FF),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF3D2A5C),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
        );

      // ── 8 · Arctic Frost ─────────────────────────────────────────────────
      case CNBPStyles.arcticFrost:
        return const CNBPStyleData(
          backgroundColor: Color(0xFFF0F4F8),
          activeColor: Color(0xFF2B6CB0),
          fabColor: Color(0xFF2B6CB0),
          activeIconColor: Colors.white,
          inactiveColor: Color(0xFFA0AEBE),
          barHeight: 98,
          fabRadius: 22,
          fabGap: 6,
          fabSink: 22,
          notchShoulderRadius: 10,
          cornerRadius: 20,
          elevation: 6,
          shadowColor: Color(0x26607D8B), // blue-grey 15 % α
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.easeOut,
          activeTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: Color(0xFF2B6CB0),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFFA0AEBE),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
        );

      // ── 9 · Berry Blossom ────────────────────────────────────────────────
      case CNBPStyles.berryBlossom:
        return const CNBPStyleData(
          backgroundColor: Color(0xFF1C0A1C),
          activeColor: Color(0xFFFF6AC1),
          fabColor: Color(0xFFFF6AC1),
          activeIconColor: Colors.white,
          inactiveColor: Color(0xFF4A1A4A),
          barHeight: 108,
          fabRadius: 24,
          fabGap: 10,
          fabSink: 14,
          notchShoulderRadius: 22,
          cornerRadius: 24,
          elevation: 20,
          shadowColor: Color(0x3FFF6AC1), // pink 25 % α
          animationDuration: Duration(milliseconds: 520),
          animationCurve: Curves.elasticOut,
          activeTextStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Color(0xFFFF6AC1),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF4A1A4A),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
        );

      // ── 10 · Golden Hour ─────────────────────────────────────────────────
      case CNBPStyles.goldenHour:
        return const CNBPStyleData(
          backgroundColor: Color(0xFF121008),
          activeColor: Color(0xFFFFD700),
          fabColor: Color(0xFFFFD700),
          activeIconColor: Color(0xFF0A0804),
          inactiveColor: Color(0xFF3A3218),
          barHeight: 104,
          fabRadius: 25,
          fabGap: 10,
          fabSink: 22,
          notchShoulderRadius: 12,
          cornerRadius: 12,
          elevation: 18,
          shadowColor: Color(0x38FFD700), // gold 22 % α
          animationDuration: Duration(milliseconds: 420),
          animationCurve: Curves.easeInOutCubic,
          activeTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
            color: Color(0xFFFFD700),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
          inactiveTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFF3A3218),
            fontFamily: 'packages/curved_navigation_bar_pro/sora',
          ),
        );
    }
  }
}
