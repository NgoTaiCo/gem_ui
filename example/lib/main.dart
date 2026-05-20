import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';

import 'pages/catalog_home.dart';

void main() => runApp(const GemUiExampleApp());

class GemUiExampleApp extends StatelessWidget {
  const GemUiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_, __) => MaterialApp(
        title: 'GEM UI Catalog',
        theme: GemTheme.light(),
        debugShowCheckedModeBanner: false,
        home: const CatalogHome(),
      ),
    );
  }
}
