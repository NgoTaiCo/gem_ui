import 'package:flutter/material.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:widgetbook/widgetbook.dart';

final buttonComponent = WidgetbookComponent(
  name: 'DsButton',
  useCases: [
    WidgetbookUseCase(
      name: 'Primary',
      builder: (context) => Center(
        child: DsButton.primary(
          label: 'Primary Button',
          onPressed: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Secondary',
      builder: (context) => Center(
        child: DsButton.secondary(
          label: 'Secondary Button',
          onPressed: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Destructive',
      builder: (context) => Center(
        child: DsButton.destructive(
          label: 'Delete',
          onPressed: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Text',
      builder: (context) => Center(
        child: DsButton.text(
          label: 'Text Button',
          onPressed: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Loading',
      builder: (context) => const Center(
        child: DsButton.primary(
          label: 'Loading',
          isLoading: true,
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => const Center(
        child: DsButton.primary(
          label: 'Disabled',
          onPressed: null,
        ),
      ),
    ),
  ],
);

final avatarComponent = WidgetbookComponent(
  name: 'DsAvatar',
  useCases: [
    WidgetbookUseCase(
      name: 'Network Image',
      builder: (context) => const Center(
        child: DsAvatar(
          name: 'Alice',
          faceUrl: 'https://i.pravatar.cc/150?u=alice',
          size: 64,
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Initials',
      builder: (context) => const Center(
        child: DsAvatar(
          name: 'Bob Smith',
          size: 64,
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Group',
      builder: (context) => const Center(
        child: DsAvatar(
          name: 'Team A',
          isGroup: true,
          size: 64,
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With Ring',
      builder: (context) => const Center(
        child: DsAvatar(
          name: 'Charlie',
          faceUrl: 'https://i.pravatar.cc/150?u=charlie',
          size: 64,
          showRing: true,
        ),
      ),
    ),
  ],
);

final badgeComponent = WidgetbookComponent(
  name: 'DsBadge',
  useCases: [
    WidgetbookUseCase(
      name: 'Count',
      builder: (context) => const Center(
        child: DsBadge.count(count: 5),
      ),
    ),
    WidgetbookUseCase(
      name: 'Count Overflow',
      builder: (context) => const Center(
        child: DsBadge.count(count: 120),
      ),
    ),
    WidgetbookUseCase(
      name: 'Dot',
      builder: (context) => const Center(
        child: DsBadge.dot(),
      ),
    ),
  ],
);

final labelComponent = WidgetbookComponent(
  name: 'DsLabel',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: DsLabel(text: 'Beta'),
      ),
    ),
    WidgetbookUseCase(
      name: 'Custom Colors',
      builder: (context) => Center(
        child: DsLabel(
          text: 'Admin',
          backgroundColor: Colors.red.shade100,
          textColor: Colors.red.shade700,
        ),
      ),
    ),
  ],
);

final emptyStateComponent = WidgetbookComponent(
  name: 'DsEmptyState',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const DsEmptyState(
        icon: Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
        title: 'No messages yet',
        subtitle: 'Start a conversation to see it here.',
      ),
    ),
    WidgetbookUseCase(
      name: 'With Action',
      builder: (context) => DsEmptyState(
        icon: const Icon(Icons.search_off_outlined, size: 64, color: Colors.grey),
        title: 'No results found',
        subtitle: 'Try adjusting your search terms.',
        action: DsButton.primary(
          label: 'Clear Search',
          onPressed: () {},
        ),
      ),
    ),
  ],
);

final loadingSpinnerComponent = WidgetbookComponent(
  name: 'DsLoadingSpinner',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: DsLoadingSpinner(),
      ),
    ),
    WidgetbookUseCase(
      name: 'With Label',
      builder: (context) => const Center(
        child: DsLoadingSpinner(label: 'Loading chats...'),
      ),
    ),
  ],
);
