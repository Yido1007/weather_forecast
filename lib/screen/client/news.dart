import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_forecast/screen/client/news_detail.dart';

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
    final String apiKey = dotenv.env['NEWSAPI_API_KEY']!;

    final current = newsQueries[langCode] ?? newsQueries['en']!;

    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=${current['query']}&language=${current['language']}&sortBy=publishedAt&apiKey=$apiKey',
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
              : _articles.isEmpty
              ? const Center(child: Text("Haber yok"))
              : ListView.separated(
                itemCount: _articles.length,
                separatorBuilder: (_, __) => const Divider(height: 24),
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => NewsDetailPage(article: article),
                        ),
                      );
                    },

                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (article['urlToImage'] != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  article['urlToImage'],
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 10),
                            Text(
                              article['title'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              article['description'] ?? '',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
