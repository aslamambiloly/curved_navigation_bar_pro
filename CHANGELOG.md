## 2.0.4

* Added more screenshots to documenation.

## 2.0.3

* Updated documentation.

## 2.0.2

* Bug fixes and performance improvements.

## 2.0.1

* Bug fixes and performance improvements.

## 2.0.0

### New Features

* **Notification Badges** — Add badges to any navigation item with `badgeText`, `badgeColor`, `badgeTextColor`, or a fully custom `badgeWidget`. Display counts ("3"), dots ("•"), or any custom widget.
* **Content Padding** — New `contentPadding` parameter to add horizontal padding to the items row. Useful when `cornerRadius` is large to prevent items from being clipped visually. Defaults to `cornerRadius` value.
* **Fixed Corner Radius Bug** — Corner radius now renders correctly with proper C¹-continuous curves and no visual artifacts.

### Improvements

* Enhanced `CurvedNavigationItemPro` with badge support properties.
* Improved geometry calculations for better visual consistency across all presets.
* Better handling of edge cases when FAB is near bar corners.
* Updated all 10 style presets to work seamlessly with the new features.

### Documentation

* Added comprehensive badge usage examples.
* Updated API reference with new parameters.
* Enhanced README with badge feature showcase.

### Breaking Changes

* None — this is a fully backward-compatible release. Existing code will continue to work without modifications.

## 1.0.16

* Bug fixes and performance improvements.

## 1.0.15

* Added `inactiveIconSize` parameter to control the size of inactive item icons.
* Added `activeIconSize` parameter to control the icon size inside the FAB bubble.
* Fixed overflow issue for long labels

## 1.0.14

* Enhanced readme with new screenshots and demo GIFs.

## 1.0.13

* Bug fixes and performance improvements.

## 1.0.12

* Updated lottie example GIF with the latest animation.

## 1.0.11

* Added `showLabel` parameter to `CurvedNavigationBarPro` widget.

## 1.0.10

* Added lottie, svg or any Widget support to `CurvedNavigationBarPro`.
* Added lottie and svg example to documentation.

## 1.0.9

* Added support for long labels.

## 1.0.8

* Added showcase, playground and showcase II GIF to documentation.
* Added 10 built-in style presets.

## 1.0.7

* Updated the pubspec.yaml with the latest screenshots

## 1.0.6

* Updated the readme with the latest screenshots

## 1.0.5

* Replaced the widget name in the readme with the latest ones

## 1.0.4

* Trigger analysis pipeline re-run.

## 1.0.3

* Added GitHub Sponsors funding config.

## 1.0.2

* Added side by side GIF layout to documentation.

## 1.0.1

* Added interactive playground example (`plaground.dart`).
* Added playground GIF to documentation.

## 1.0.0

* Initial release.
* `CurvedNavigationBarPro` widget with smooth animated curved notch.
* `CurvedNavigationItemPro` model with optional `activeIcon`.
* Elastic FAB bubble pop-in animation.
* C¹-continuous shoulder curves for a mathematically smooth notch.
* Full theming support: colours, elevation, geometry, text styles.
* Accessibility semantics for all nav items.
* 2–6 items supported.