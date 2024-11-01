import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  static const String apiKey = 'key-openai';

  static Future<String> getResponse(String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json; charset=utf-8',
    };
    final body = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
    });

    try {

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {

        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'];
      } else {
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
  static Future<String> getRecipeFromIngredients(List<String> ingredients) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json; charset=utf-8',
    };
    final prompt = 'Dame una receta usando estos ingredientes: ${ingredients.join(", ")}';
    
    final body = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'];
      } else {
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
  static Future<String> fetchCalories(String foodItem) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json; charset=utf-8',
    };
    final body = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'user',
          'content': '¿Cuántas calorías tiene aproximadamente $foodItem por cada 100 gramos?',
        },
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'].toString();
      } else {
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
