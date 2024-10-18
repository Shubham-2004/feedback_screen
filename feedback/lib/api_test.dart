import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  Future<void> callapi(String url) async {
    if (url.isEmpty) {
      throw Exception('Please provide a valid API URL.');
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter API URL',
              ),
              onSubmitted: (url) => callapi(url),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => callapi('https://api.helpscout.net/v2'),
              child: const Text('Call API (Default)'),
            ),
          ],
        ),
      ),
    );
  }
}
