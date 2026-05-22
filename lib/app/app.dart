import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'router.dart';
import 'theme/app_theme.dart';

class RunWarsApp extends StatefulWidget {
  const RunWarsApp({super.key});

  @override
  State<RunWarsApp> createState() => _RunWarsAppState();
}

class _RunWarsAppState extends State<RunWarsApp> {
  @override
  void initState() {
    super.initState();
    Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL', defaultValue: 'https://example.supabase.co'),
      anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: 'anon-key'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RunWars',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
