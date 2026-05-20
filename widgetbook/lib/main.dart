import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components/cards.dart';
import 'components/forms.dart';
import 'components/layout.dart';
import 'components/primitives.dart';

void main() {
  runApp(const GemWidgetbook());
}

class GemWidgetbook extends StatelessWidget {
  const GemWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appBuilder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: GemTheme.light(),
              home: child,
            );
          },
        );
      },
      directories: [
        WidgetbookFolder(
          name: 'Primitives',
          children: [
            buttonComponent,
            avatarComponent,
            badgeComponent,
            labelComponent,
            emptyStateComponent,
            loadingSpinnerComponent,
          ],
        ),
        WidgetbookFolder(
          name: 'Layout',
          children: [
            appBarComponent,
            dashboardHeaderComponent,
            flatRowComponent,
            sectionCardComponent,
            sectionTitleComponent,
            checkedConfirmComponent,
          ],
        ),
        WidgetbookFolder(
          name: 'Forms',
          children: [
            textFieldComponent,
            searchFieldComponent,
            otpFieldComponent,
          ],
        ),
        WidgetbookFolder(
          name: 'Cards',
          children: [
            personCardComponent,
            settingsTileComponent,
            knowledgeCardComponent,
            merchantItemComponent,
          ],
        ),
      ],
    );
  }
}
