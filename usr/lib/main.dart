import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/idea_generator_screen.dart';
import 'screens/script_writer_screen.dart';
import 'screens/caption_generator_screen.dart';

void main() {
  runApp(const ContentCreatorApp());
}

class ContentCreatorApp extends StatelessWidget {
  const ContentCreatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creator AI Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/idea': (context) => const IdeaGeneratorScreen(),
        '/script': (context) => const ScriptWriterScreen(),
        '/caption': (context) => const CaptionGeneratorScreen(),
      },
    );
  }
}
