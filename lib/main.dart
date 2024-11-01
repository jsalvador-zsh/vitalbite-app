import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart' as chat;
import 'screens/recipe_screen.dart' as recipe;
import 'screens/calorie_calculator_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¡Qué Cocinar!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
      routes: {
        '/chat': (context) => const chat.ChatScreen(),
        '/recipe': (context) => const recipe.ChatScreen(),
        '/calorie-calculator': (context) => const CalorieCalculatorScreen(),
      },
    );
  }
}
