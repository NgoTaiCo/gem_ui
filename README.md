# GEM UI

GEM UI is a versioned Flutter design-system package for chat and social
applications. It provides one package import for all GEM APIs, one light theme,
tokenized visual primitives, application layout pieces, list rows, cards, chat
widgets, and bottom sheets.

## Features

- Token-driven color, typography, spacing, radius, and shadow system.
- Light-mode-only by design: one `GemTheme.light()` theme and no runtime theme
  configuration.
- Components are built on Flutter Material/Cupertino widgets and Navigator APIs.
- No GetX dependency. Reactive state, SDK models, and localization stay in the
  host app.
- Uses `flutter_screenutil`; host apps must initialize `ScreenUtilInit`.

## Install

```yaml
dependencies:
  gem_ui: ^1.0.0
```

`gem_ui` depends on `flutter_screenutil`, `lucide_icons_flutter`,
`extended_image`, `qr_flutter`, and `intl`. Import `lucide_icons_flutter` in
consumer code when passing Lucide icons to GEM components.

## App Setup

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_, __) => MaterialApp(
        title: 'GEM',
        theme: GemTheme.light(),
        home: const HomeScreen(),
      ),
    );
  }
}
```

## Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

final c = context.colorTokens;

DsAvatar(name: 'Alice', faceUrl: 'https://example.com/a.png', size: 48);
DsSearchField(hintText: 'Search', controller: searchController);
DsSettingsTile(icon: LucideIcons.settings, title: 'Account');
DsPersonCard(name: 'Alice', subtitle: 'ID: 12345');
```

## Public API Overview

### Tokens

- `GemTheme.light()`
- `AppColorTokens`, `GemColorTokens`, and `context.colorTokens`
- `AppTextStyles`
- `AppSpacing` and `AppSpacingExt`
- `AppRadius`
- `AppShadows`

### Primitives

- `DsAvatar`
- `DsBadge.count`, `DsBadge.dot`
- `DsButton.primary`, `DsButton.secondary`, `DsButton.destructive`,
  `DsButton.text`
- `DsEmptyState`
- `DsLoadingSpinner`
- `DsLabel`
- `DsTabItem`, `DsTabStrip`

### Layout

- `DsDashboardHeader`
- `DsAppBar`
- `DsCheckedConfirm`
- `DsFlatRow`
- `DsSectionCard`
- `DsSectionTitle`

### Forms

- `DsTextField`
- `DsSearchField`
- `DsOtpField`

### Cards

- `DsPersonCard`
- `DsSettingsTile`
- `DsKnowledgeItem`, `DsKnowledgeCard`
- `DsMerchantItemData`, `DsMerchantItem`

### Lists

- `DsMenuItem`
- `DsCustomSwitch`
- `DsMenuItemSwitch`
- `DsMenuItemValue`
- `DsMenuItemSubtitle`
- `DsMenuSection`
- `DsFriendItemData`, `DsFriendItem`
- `DsGroupItemData`, `DsGroupItem`

### Sheets

- `showDsSetRemarkSheet`, `DsSetRemarkSheet`
- `showDsFontSizeSheet`, `DsFontSizeSheet`
- `showDsChatBackgroundSheet`, `DsChatBackgroundSheet`
- `showDsQrSheet`, `DsQrSheet`
- `showDsMuteSheet`, `DsMuteLabels`
- `DsSelectedItemsSheet`, `DsSelectedItemCard`
- `DsDatePicker`

### Chat

- `AuthBackButton`
- `DsChatBubble`
- `DsChatSystemMessage`, `DsSystemMessageType`
- `DsChatHeader`
- `DsChatHeaderActionButton`

## Bottom Sheet Examples

```dart
await showDsSetRemarkSheet(
  context,
  initialRemark: 'Alice',
  onSave: (remark) => saveRemark(remark),
);

final muteSeconds = await showDsMuteSheet(
  context: context,
  currentlyMuted: false,
);

await showDsQrSheet(
  context,
  data: 'gem://user/123',
  title: 'Alice',
  subtitle: 'Scan to add contact',
);
```

`DsDatePicker` is a dialog widget:

```dart
final date = await showDialog<DateTime>(
  context: context,
  builder: (_) => DsDatePicker(
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  ),
);
```

## Example Catalog

The `example` app is a component catalog.

```bash
cd example
flutter pub get
flutter run
```

## Reskinning

To reskin GEM UI for another product, fork the package and change the brand
constants in `lib/src/tokens/color_tokens.dart`, then publish under a new
package name or version. Components read colors from `context.colorTokens`, so
the accent and semantic colors flow through the package from that single source.

## Notes

- The package is intentionally light-mode-only.
- The package does not bundle app-specific SDK models or GetX state.
- User-visible labels are constructor parameters where the component owns text.
  Some low-level display widgets render exactly the text passed by the caller.
- `DsMerchantItem` accepts an `avatarAsset`; if the asset cannot be loaded it
  falls back to a tokenized company icon.

## Versioning

Breaking API changes require a semver major version. Breaking visual changes
should ship as a semver minor or major depending on consumer impact.
