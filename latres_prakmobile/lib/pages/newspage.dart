import 'package:flutter/material.dart';
import '../data/report.dart';

class NewsPage extends StatelessWidget {
  final ClassName data; // Data yang diterima

  NewsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
      ),
      body: ListView.builder(
        itemCount: data.results?.length ?? 0,
        itemBuilder: (context, index) {
          final result = data.results![index];
          return ListTile(
            title: Text(result.title ?? 'No Title'),
            subtitle: Text(result.summary ?? 'No Summary'),
          );
        },
      ),
    );
  }
}
