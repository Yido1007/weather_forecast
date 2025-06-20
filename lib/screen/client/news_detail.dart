import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NewsDetailPage extends StatelessWidget {
  final Map article;
  const NewsDetailPage({super.key, required this.article});

  String cleanContent(String? content) {
    if (content == null) return '';
    return content.replaceAll(RegExp(r'\s*\[\+\d+\s+chars\]'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article['title'] ?? 'Haber Detayı',
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  article['urlToImage'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const Gap(20),
            Text(
              article['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const Gap(14),
            if ((article['description'] ?? '').isNotEmpty)
              Text(
                article['description'] ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            const Gap(16),
            if ((article['content'] ?? '').isNotEmpty)
              Text(
                cleanContent(article['content']),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
