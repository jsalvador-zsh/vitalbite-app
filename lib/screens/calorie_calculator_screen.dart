import 'package:flutter/material.dart';
import '../services/openai_service.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({super.key});

  @override
  _CalorieCalculatorScreenState createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final TextEditingController _foodController = TextEditingController();
  String _calories = '';
  bool _isLoading = false;

  Future<void> _calculateCalories() async {
    String foodItem = _foodController.text.toLowerCase();

    setState(() {
      _isLoading = true;
      _calories = '';
    });

    try {
      String caloriesResponse = await OpenAIService.fetchCalories(foodItem);
      setState(() {
        _calories = caloriesResponse;
      });
    } catch (error) {
      setState(() {
        _calories = 'Error al buscar datos: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    _foodController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Calorías'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduce el alimento:',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _foodController,
              decoration: InputDecoration(
                hintText: 'Ejemplo: pechuga de pollo',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _isLoading ? null : _calculateCalories,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Calorías:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _isLoading
                  ? 'Buscando...'
                  : _calories.isEmpty
                      ? '¡Ingresa un alimento!'
                      : _calories,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
