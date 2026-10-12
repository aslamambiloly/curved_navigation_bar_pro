import 'package:flutter/services.dart';

/// Defines the haptic feedback style or custom haptic behavior for
/// `CurvedNavigationBarPro`.
///
/// Use one of the pre-configured styles or provide a custom callback:
/// - [CNBPHapticFeedback.selectionClick] (default)
/// - [CNBPHapticFeedback.lightImpact]
/// - [CNBPHapticFeedback.mediumImpact]
/// - [CNBPHapticFeedback.heavyImpact]
/// - [CNBPHapticFeedback.vibrate]
/// - [CNBPHapticFeedback.none] (disable haptics)
/// - [CNBPHapticFeedback.custom] (custom parameterless callback)
/// - [CNBPHapticFeedback.customWithIndex] (custom callback receiving the tapped index)
abstract class CNBPHapticFeedback {
  /// Const constructor for subclasses.
  const CNBPHapticFeedback();

  /// Creates custom haptic feedback with a parameterless callback.
  const factory CNBPHapticFeedback.custom(void Function() onTrigger) =
      _CustomHapticFeedback;

  /// Creates custom haptic feedback that receives the tapped navigation item index.
  const factory CNBPHapticFeedback.customWithIndex(
      void Function(int index) onTrigger) = _CustomIndexHapticFeedback;

  /// Triggers the haptic feedback, optionally passing the tapped item [index].
  void trigger([int? index]);

  /// No haptic feedback.
  static const CNBPHapticFeedback none = _NoneHapticFeedback();

  /// A selection click haptic (standard for bottom navigation bars and pickers).
  static const CNBPHapticFeedback selectionClick =
      _SelectionClickHapticFeedback();

  /// A subtle light impact haptic.
  static const CNBPHapticFeedback lightImpact = _LightImpactHapticFeedback();

  /// A medium impact haptic.
  static const CNBPHapticFeedback mediumImpact = _MediumImpactHapticFeedback();

  /// A heavy impact haptic.
  static const CNBPHapticFeedback heavyImpact = _HeavyImpactHapticFeedback();

  /// A standard vibration haptic.
  static const CNBPHapticFeedback vibrate = _VibrateHapticFeedback();
}

class _NoneHapticFeedback extends CNBPHapticFeedback {
  const _NoneHapticFeedback();

  @override
  void trigger([int? index]) {}
}

class _SelectionClickHapticFeedback extends CNBPHapticFeedback {
  const _SelectionClickHapticFeedback();

  @override
  void trigger([int? index]) {
    HapticFeedback.selectionClick();
  }
}

class _LightImpactHapticFeedback extends CNBPHapticFeedback {
  const _LightImpactHapticFeedback();

  @override
  void trigger([int? index]) {
    HapticFeedback.lightImpact();
  }
}

class _MediumImpactHapticFeedback extends CNBPHapticFeedback {
  const _MediumImpactHapticFeedback();

  @override
  void trigger([int? index]) {
    HapticFeedback.mediumImpact();
  }
}

class _HeavyImpactHapticFeedback extends CNBPHapticFeedback {
  const _HeavyImpactHapticFeedback();

  @override
  void trigger([int? index]) {
    HapticFeedback.heavyImpact();
  }
}

class _VibrateHapticFeedback extends CNBPHapticFeedback {
  const _VibrateHapticFeedback();

  @override
  void trigger([int? index]) {
    HapticFeedback.vibrate();
  }
}

class _CustomHapticFeedback extends CNBPHapticFeedback {
  const _CustomHapticFeedback(this.onTrigger);

  final void Function() onTrigger;

  @override
  void trigger([int? index]) {
    onTrigger();
  }
}

class _CustomIndexHapticFeedback extends CNBPHapticFeedback {
  const _CustomIndexHapticFeedback(this.onTrigger);

  final void Function(int index) onTrigger;

  @override
  void trigger([int? index]) {
    if (index != null) {
      onTrigger(index);
    }
  }
}
