import 'package:flutter/material.dart';
import 'package:latres_prakmobile/pages/homepage.dart';
import 'package:latres_prakmobile/pages/login.dart';
import 'package:latres_prakmobile/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('username');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        // Tampilkan loading jika proses belum selesai
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final isLoggedIn = snapshot.data ?? false;

        return MaterialApp(
          title: 'Flutter App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: isLoggedIn ? '/home' : '/', // Rute awal
          routes: {
            '/': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/home': (context) => HomePage(
                  // Tambahkan dummy data untuk testing atau API call nantinya
                  newsData: null,
                  blogData: null,
                  reportData: null,
                ),
          },
        );
      },
    );
  }
}
