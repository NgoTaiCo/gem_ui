import 'package:flutter/material.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'primitives_page.dart';
import 'layout_page.dart';
import 'forms_page.dart';
import 'cards_page.dart';
import 'lists_page.dart';
import 'sheets_page.dart';
import 'chat_page.dart';

class CatalogHome extends StatefulWidget {
  const CatalogHome({super.key});

  @override
  State<CatalogHome> createState() => _CatalogHomeState();
}

class _CatalogHomeState extends State<CatalogHome> {
  int _selectedIndex = 0;

  static const _pages = [
    PrimitivesPage(),
    LayoutPage(),
    FormsPage(),
    CardsPage(),
    ListsPage(),
    SheetsPage(),
    ChatPage(),
  ];

  static const _destinations = [
    NavigationRailDestination(
      icon: Icon(LucideIcons.square),
      label: Text('Primitives'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.layoutTemplate),
      label: Text('Layout'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.textCursorInput),
      label: Text('Forms'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.creditCard),
      label: Text('Cards'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.list),
      label: Text('Lists'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.panelBottom),
      label: Text('Sheets'),
    ),
    NavigationRailDestination(
      icon: Icon(LucideIcons.messageSquare),
      label: Text('Chat'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Scaffold(
      backgroundColor: c.surface,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (i) => setState(() => _selectedIndex = i),
            labelType: NavigationRailLabelType.all,
            destinations: _destinations,
            backgroundColor: c.surfaceRaised,
            selectedIconTheme: IconThemeData(color: c.accent),
            selectedLabelTextStyle:
                AppTextStyles.label.copyWith(color: c.accent),
            unselectedIconTheme: IconThemeData(color: c.contentSecondary),
            unselectedLabelTextStyle:
                AppTextStyles.label.copyWith(color: c.contentSecondary),
          ),
          VerticalDivider(width: 1, thickness: 1, color: c.divider),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}
