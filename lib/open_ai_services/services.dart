import 'dart:convert';
import 'package:algo_ai_chat_bot/secret/secret_key.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class OpenAIServices {
  List<Map<String, String>> messages = [];
  final String chatUrl = "https://api.openai.com/v1/chat/completions";
  final String dallEUrl = "https://api.openai.com/v1/images/generations";

  Future<String> isArtOrTextPrompt(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(chatUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer $openAIApiKey", // Make sure you have openAI_Api_Key defined somewhere
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
              "Does this message want to generate an AI image, picture, art, photo or anything similar? $prompt. Simply reply with a YES or NO.",
            }
          ],
        }),
      );

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        String content = jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content.toLowerCase()) {
          case 'yes':
          case 'Yes':
          case 'YES':
          case 'yes.':
          case 'Yes.':
          case 'YES.':
            final response = await isDallE(prompt);
            return response;
          default:
            final response = await isChatGPT(prompt);
            return response;
        }
      }
      
      return 'An internal error occurred';
      
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> isChatGPT(String prompt) async {

    messages.add({'role': 'user', 'content': prompt});

    try {
      final response = await http.post(
          Uri.parse(chatUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAIApiKey", // Make sure you have openAIApiKey defined somewhere
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        })
      );

      if (response.statusCode == 200) {
        String content = jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          "role": "assistant",
          "content": content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> isDallE(String prompt) async {
    messages.add({"role": "user", "content": prompt});

    try {
      final response = await http.post(
        Uri.parse(dallEUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAIApiKey", // Make sure you have openAI_Api_Key defined somewhere
        },
        body: jsonEncode({"prompt": prompt, "n": 1, "size": "1024x1024"}),
      );

      if (response.statusCode == 200) {
        String imageUrl = jsonDecode(response.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        messages.add({
          "role": "assistant",
          "content": imageUrl,
        });
        return imageUrl;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
