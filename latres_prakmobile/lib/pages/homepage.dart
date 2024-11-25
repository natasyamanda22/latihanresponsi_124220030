import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/report.dart'; // Data model: ClassName dan Results
import 'blogpage.dart';
import 'newspage.dart';
import 'reportpage.dart';

class HomePage extends StatelessWidget {
  final ClassName newsData; // Data untuk NewsPage
  final ClassName blogData; // Data untuk BlogPage
  final ClassName reportData; // Data untuk ReportPage

  HomePage({
    required this.newsData,
    required this.blogData,
    required this.reportData,
  });

  Future<String> _getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'User'; // Default username
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: FutureBuilder<String>(
        future: _getUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final username = snapshot.data;

          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Halo, Selamat Datang $username',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Latest News'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsPage(data: newsData),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text('Tech Blog'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogPage(data: blogData),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text('Monthly Report'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportPage(data: reportData),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
