import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherNewsScreen extends StatefulWidget {
  const WeatherNewsScreen({super.key});

  @override
  State<WeatherNewsScreen> createState() => _WeatherNewsScreenState();
}

class _WeatherNewsScreenState extends State<WeatherNewsScreen> {
  List _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  final Map<String, Map<String, String>> newsQueries = {
    'tr': {
      'query': '"hava durumu" OR meteoroloji',
      'language': 'tr',
      'filter': 'hava durumu',
    },
    'en': {
      'query': '"weather forecast" OR "weather report" OR meteorology',
      'language': 'en',
      'filter': 'weather',
    },
  };

  Future<void> fetchWeatherNews(String langCode) async {
    final String apiKey = dotenv.env['OPENWEATHER_API_KEY']!;

    final current = newsQueries[langCode] ?? newsQueries['en'];

    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=${current!['query']}&language=${current['language']}&sortBy=publishedAt&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List articles = data['articles'];

      final filterWord = current['filter']?.toLowerCase() ?? '';
      if (filterWord.isNotEmpty) {
        articles =
            articles.where((article) {
              final title = (article['title'] ?? '').toLowerCase();
              final desc = (article['description'] ?? '').toLowerCase();
              return title.contains(filterWord) || desc.contains(filterWord);
            }).toList();
      }

      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _articles.isEmpty) {
      final langCode = Localizations.localeOf(context).languageCode;
      fetchWeatherNews(langCode);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Hava Durumu Haberleri')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                itemCount: _articles.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return ListTile(
                    leading:
                        article['urlToImage'] != null
                            ? Image.network(
                              article['urlToImage'],
                              width: 60,
                              fit: BoxFit.cover,
                            )
                            : null,
                    title: Text(article['title'] ?? ''),
                    subtitle: Text(article['description'] ?? ''),
                    onTap: () {
                      if (article['url'] != null) {}
                    },
                  );
                },
              ),
    );
  }
}
