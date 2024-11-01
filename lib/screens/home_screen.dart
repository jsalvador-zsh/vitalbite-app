import 'package:flutter/material.dart';
import '../widgets/bento_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¡Qué Cocinar!'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: BentoCard(
                title: 'Hablar con IA',
                imagePath: 'assets/chat.png',
                onTap: () {
                  Navigator.pushNamed(context, '/chat');
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BentoCard(
                title: 'Recetas',
                imagePath: 'assets/recipe.png',
                onTap: () {
                  Navigator.pushNamed(context, '/recipe');
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BentoCard(
                title: 'Calculadora de Calorías',
                imagePath: 'assets/calories.png',
                onTap: () {
                  Navigator.pushNamed(context, '/calorie-calculator');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
