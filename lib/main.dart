import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/auth/auth_gate.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  final url = dotenv.env['SUPABASE_URL'];
  final anonKey = dotenv.env['SUPABASE_ANON_KEY'];
  if (url == null || url.isEmpty || anonKey == null || anonKey.isEmpty) {
    throw Exception('Add your Supabase URL and anon key to .env before running the app.');
  }

  await Supabase.initialize(url: url, publishableKey: anonKey);

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
      home: const AuthGate(),
    );
  }
}
