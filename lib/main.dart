import 'package:flutter/material.dart';
import 'package:magicslide/core/services/supabase_service.dart';
import 'package:magicslide/features/auth/view/login_screen.dart';

import 'features/home/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MagicSlides',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.light(),
      themeMode: ThemeMode.system,
      home: SupabaseService.client.auth.currentSession == null
          ? const LoginScreen()
          : const HomeScreen(),
      routes: {
        '/login': (_) => const LoginScreen(),
      },

    );
  }
}