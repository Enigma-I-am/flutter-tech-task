import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:tech_task/presentation/views/home_page.dart';
import 'core/service/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator.key,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.green,
        brightness: Brightness.light,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.green,
          selectionHandleColor: Colors.green,
          selectionColor: Colors.green.withOpacity(0.1),
        ),
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light(
          primary: Colors.green,
          background: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}








