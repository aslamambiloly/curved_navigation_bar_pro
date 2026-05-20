# Migration Guide: v1.0.16 → v2.0.0

## Overview

Good news! **v2.0.0 is fully backward compatible** with v1.0.16. Your existing code will work without any changes. This guide shows you how to use the new features.

---

## No Breaking Changes

Your existing code will continue to work exactly as before:

```dart
// This still works perfectly in v2.0.0
CurvedNavigationBarPro(
  items: const [
    CurvedNavigationItemPro(
      inactiveIcon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    CurvedNavigationItemPro(
      inactiveIcon: Icons.favorite_outline,
      activeIcon: Icons.favorite_rounded,
      label: 'Saved',
    ),
  ],
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
)
```

---

## New Features to Explore

### 1. Adding Badges

Add notification badges to your items:

```dart
CurvedNavigationItemPro(
  inactiveIcon: Icons.mail_outline,
  activeIcon: Icons.mail_rounded,
  label: 'Messages',
  badgeText: '5',  // ← NEW
)
```

**Badge options:**
```dart
CurvedNavigationItemPro(
  inactiveIcon: Icons.notifications_outlined,
  activeIcon: Icons.notifications_rounded,
  label: 'Alerts',
  badgeText: '3',                    // Text badge
  badgeColor: Colors.red,            // Custom color
  badgeTextColor: Colors.white,      // Custom text color
)
```

**Custom badge widget:**
```dart
CurvedNavigationItemPro(
  inactiveIcon: Icons.shopping_cart_outlined,
  activeIcon: Icons.shopping_cart_rounded,
  label: 'Cart',
  badgeWidget: Container(  // ← Fully custom
    width: 20,
    height: 20,
    decoration: const BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    child: const Center(
      child: Text('5', style: TextStyle(color: Colors.white, fontSize: 10)),
    ),
  ),
)
```

### 2. Using Content Padding

Add padding to prevent items from being clipped with large corner radius:

```dart
CurvedNavigationBarPro(
  items: myItems,
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
  cornerRadius: 20,        // Large corners
  contentPadding: 16,      // ← NEW: Add padding
)
```

**Default behavior:**
If you don't specify `contentPadding`, it automatically defaults to the `cornerRadius` value:

```dart
CurvedNavigationBarPro(
  items: myItems,
  cornerRadius: 20,
  // contentPadding automatically becomes 20
)
```

### 3. Using Presets with New Features

All 10 style presets now support the new features:

```dart
CurvedNavigationBarPro(
  items: myItems,
  navbarStyle: CNBPStyles.goldenHour,  // Includes contentPadding
  onTap: (i) => setState(() => _index = i),
)
```

---

## Common Use Cases

### Use Case 1: Shopping App with Cart Badge

```dart
CurvedNavigationBarPro(
  items: [
    CurvedNavigationItemPro(
      inactiveIcon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    CurvedNavigationItemPro(
      inactiveIcon: Icons.search_outlined,
      activeIcon: Icons.search_rounded,
      label: 'Search',
    ),
    CurvedNavigationItemPro(
      inactiveIcon: Icons.shopping_cart_outlined,
      activeIcon: Icons.shopping_cart_rounded,
      label: 'Cart',
      badgeText: cartCount.toString(),  // Show item count
      badgeColor: Colors.red,
    ),
    CurvedNavigationItemPro(
      inactiveIcon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ],
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
)
```

### Use Case 2: Messaging App with Multiple Badges

```dart
CurvedNavigationBarPro(
  items: [
    CurvedNavigationItemPro(
      inactiveIcon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    CurvedNavigationItemPro(
      inactiveIcon: Icons.mail_outline,
      activeIcon: Icons.mail_rounded,
      label: 'Messages',
      badgeText: unreadMessages.toString(),
      badgeColor: Colors.blue,
    ),
    CurvedNavigationItemPro(
      inactiveIcon: Icons.notifications_outlined,
      activeIcon: Icons.notifications_rounded,
      label: 'Notifications',
      badgeText: unreadNotifications > 0 ? '•' : null,  // Dot badge
      badgeColor: Colors.orange,
    ),
    CurvedNavigationItemPro(
      inactiveIcon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ],
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
)
```

### Use Case 3: Rounded Corners with Proper Padding

```dart
CurvedNavigationBarPro(
  items: myItems,
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
  cornerRadius: 24,        // Large rounded corners
  contentPadding: 12,      // Prevent item clipping
  navbarStyle: CNBPStyles.roundedCoral,
)
```

---

## FAQ

**Q: Do I need to update my code?**
A: No! Your existing code will work as-is. The new features are optional.

**Q: What's the default badge color?**
A: Red (`Color(0xFFE53935)`). You can customize it with `badgeColor`.

**Q: Can I remove a badge?**
A: Yes, set `badgeText` to `null` or an empty string.

**Q: What if I use a custom `badgeWidget`?**
A: It will override `badgeText`, `badgeColor`, and `badgeTextColor`.

**Q: Does `contentPadding` affect the FAB position?**
A: No, the FAB position is calculated independently. `contentPadding` only affects the items row.

**Q: Can I use badges with custom widgets (SVG, Lottie)?**
A: Yes! Badges work with any icon type.

---

## Troubleshooting

### Items are clipped with large corner radius

**Solution:** Add `contentPadding`:
```dart
CurvedNavigationBarPro(
  items: myItems,
  cornerRadius: 24,
  contentPadding: 16,  // ← Add this
)
```

### Badge is not showing

**Check:**
1. Is `badgeText` set and not empty?
2. Is `badgeWidget` provided (overrides text badge)?
3. Are you using the latest version (2.0.0)?

### Badge position looks off

**Solution:** The badge position is automatically calculated. If it looks wrong, try:
1. Adjusting `inactiveIconSize` or `activeIconSize`
2. Using a custom `badgeWidget` for more control

---

## Summary

| Feature | v1.0.16 | v2.0.0 | Action |
|---------|---------|--------|--------|
| Existing code | ✅ | ✅ | No changes needed |
| Badges | ❌ | ✅ | Optional — add when needed |
| Content padding | ❌ | ✅ | Optional — use for rounded corners |
| Corner radius | ⚠️ | ✅ | Works better now |

**That's it! Enjoy the new features in v2.0.0! 🎉**
