import 'package:flutter/material.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:widgetbook/widgetbook.dart';

final appBarComponent = WidgetbookComponent(
  name: 'DsAppBar',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => Scaffold(
        appBar: const DsAppBar(title: 'Settings'),
        body: Container(),
      ),
    ),
    WidgetbookUseCase(
      name: 'With Action',
      builder: (context) => Scaffold(
        appBar: DsAppBar(
          title: 'Profile',
          action: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ),
        body: Container(),
      ),
    ),
  ],
);

final dashboardHeaderComponent = WidgetbookComponent(
  name: 'DsDashboardHeader',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => Scaffold(
        appBar: const DsDashboardHeader(title: 'Dashboard'),
        body: Container(),
      ),
    ),
    WidgetbookUseCase(
      name: 'With Action',
      builder: (context) => Scaffold(
        appBar: DsDashboardHeader(
          title: 'Chats',
          action: IconButton(
            icon: const Icon(Icons.add_comment_outlined),
            onPressed: () {},
          ),
        ),
        body: Container(),
      ),
    ),
  ],
);

final flatRowComponent = WidgetbookComponent(
  name: 'DsFlatRow',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: DsFlatRow(
          icon: Icons.person_outline,
          label: 'Account',
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With Subtitle',
      builder: (context) => const Center(
        child: DsFlatRow(
          icon: Icons.notifications_none,
          label: 'Notifications',
          subtitle: 'Enabled',
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'No Chevron',
      builder: (context) => const Center(
        child: DsFlatRow(
          icon: Icons.info_outline,
          label: 'Version',
          showChevron: false,
          trailing: Text('1.0.0'),
        ),
      ),
    ),
  ],
);

final sectionCardComponent = WidgetbookComponent(
  name: 'DsSectionCard',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: DsSectionCard(
          title: 'Settings',
          children: [
            DsFlatRow(
              icon: Icons.person_outline,
              label: 'Account',
            ),
            DsFlatRow(
              icon: Icons.lock_outline,
              label: 'Privacy',
            ),
            DsFlatRow(
              icon: Icons.notifications_none,
              label: 'Notifications',
            ),
          ],
        ),
      ),
    ),
  ],
);

final sectionTitleComponent = WidgetbookComponent(
  name: 'DsSectionTitle',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: DsSectionTitle(
          icon: LucideIcons.user,
          label: 'Personal Information',
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Required',
      builder: (context) => const Center(
        child: DsSectionTitle(
          icon: LucideIcons.mail,
          label: 'Email',
          required: true,
        ),
      ),
    ),
  ],
);

final checkedConfirmComponent = WidgetbookComponent(
  name: 'DsCheckedConfirm',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => Center(
        child: DsCheckedConfirm(
          checkedCount: 3,
          selectedCountLabel: '3 selected',
          confirmLabel: 'Confirm (3 / 50)',
          onConfirm: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Empty',
      builder: (context) => Center(
        child: DsCheckedConfirm(
          checkedCount: 0,
          selectedCountLabel: '0 selected',
          confirmLabel: 'Confirm (0 / 50)',
          onConfirm: () {},
          enableConfirm: false,
        ),
      ),
    ),
  ],
);
