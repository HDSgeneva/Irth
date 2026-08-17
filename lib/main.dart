import 'package:flutter/material.dart';

import 'app_shell.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const IrthApp());
}

class IrthApp extends StatelessWidget {
  const IrthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irth',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const AppShell(),
    );
  }
}
