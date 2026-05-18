import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/match_provider.dart';
import 'providers/standing_provider.dart';
import 'screens/main_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MatchProvider()),
        ChangeNotifierProvider(create: (_) => StandingProvider()),
      ],
      child: const MundoCupApp(),
    ),
  );
}

class MundoCupApp extends StatelessWidget {
  const MundoCupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MundoCup 2026',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Padrão escuro conforme solicitado
      home: const MainNavigation(),
    );
  }
}
