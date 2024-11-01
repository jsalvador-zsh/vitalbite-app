import 'package:flutter/material.dart';
import '../services/openai_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _ingredients = [];
  String _response = '';
  bool _isLoading = false;

  void _sendIngredients() async {
    if (_ingredients.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    String response = await OpenAIService.getRecipeFromIngredients(_ingredients);

    setState(() {
      _response = response;
      _isLoading = false;
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hablar con IA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._ingredients.map((ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.circle, size: 8),
                              const SizedBox(width: 8),
                              Text(ingredient),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                    const Text(
                      'Respuesta:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Text(
                        _response.isEmpty ? '¡Añade ingredientes para una receta!' : _response,
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Añade un ingrediente...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (_controller.text.isNotEmpty) {
                        _ingredients.add(_controller.text);
                        _controller.clear();
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendIngredients,
              child: const Text('Obtener receta'),
            ),
          ],
        ),
      ),
    );
  }
}
