import 'package:flutter/material.dart';

import 'pres/pages/scaffold_page.dart';
import 'style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: SCol.createMaterialColor(SCol.primary),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 30, color: SCol.onBackground)),
        textTheme: TextTheme(
          headlineMedium: TextStyle(color: SCol.onBackground),
          titleLarge: TextStyle(color: SCol.onBackground),
          displayMedium: TextStyle(color: SCol.onBackground),
        ),
        useMaterial3: true,
      ),
      home: const ScaffoldPage(),
    );
  }
}
