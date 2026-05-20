import 'package:flutter/material.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:widgetbook/widgetbook.dart';

final personCardComponent = WidgetbookComponent(
  name: 'DsPersonCard',
  useCases: [
    WidgetbookUseCase(
      name: 'Person',
      builder: (context) => Center(
        child: DsPersonCard(
          name: 'Alice Nguyen',
          subtitle: 'Product Designer',
          faceUrl: 'https://i.pravatar.cc/150?u=alice',
          onTap: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Group',
      builder: (context) => Center(
        child: DsPersonCard(
          name: 'Engineering Team',
          subtitle: '12 members',
          isGroup: true,
          onTap: () {},
        ),
      ),
    ),
  ],
);

final settingsTileComponent = WidgetbookComponent(
  name: 'DsSettingsTile',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: DsSettingsTile(
          icon: Icons.palette_outlined,
          title: 'Appearance',
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With Toggle',
      builder: (context) => Center(
        child: DsSettingsTile(
          icon: Icons.notifications_none,
          title: 'Notifications',
          trailing: Switch(
            value: true,
            onChanged: (_) {},
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Destructive',
      builder: (context) => const Center(
        child: DsSettingsTile(
          icon: Icons.delete_outline,
          title: 'Delete Account',
          isDestructive: true,
        ),
      ),
    ),
  ],
);

final knowledgeCardComponent = WidgetbookComponent(
  name: 'DsKnowledgeCard',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: DsKnowledgeCard(
          items: [
            DsKnowledgeItem(
              title: 'Q: What is SOLID?',
              description: 'A set of 5 OOP design principles that help build maintainable software.',
            ),
            DsKnowledgeItem(
              title: 'Q: What is Flutter?',
              description: 'An open-source UI toolkit for building natively compiled applications.',
            ),
          ],
        ),
      ),
    ),
  ],
);

final merchantItemComponent = WidgetbookComponent(
  name: 'DsMerchantItem',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => Center(
        child: DsMerchantItem(
          data: const DsMerchantItemData(
            id: 'CMP-001',
            inviteCode: 'COFFEE2024',
            displayInviteCode: 'COFFEE2024',
          ),
          btnLabel: 'Select',
          onBtnTap: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Current',
      builder: (context) => Center(
        child: DsMerchantItem(
          data: const DsMerchantItemData(
            id: 'CMP-002',
            inviteCode: 'TEA2024',
            displayInviteCode: 'TEA2024',
          ),
          btnLabel: 'Switch',
          onBtnTap: () {},
          isCurrent: true,
        ),
      ),
    ),
  ],
);
