import 'package:flutter/material.dart';
import 'package:latres_prakmobile/sevices/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart'; // Pastikan HomePage diimpor dengan benar
import '../data/report.dart'; // Untuk data dummy jika diperlukan

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _database = Database();

  bool _isLoading = false;

  void _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both username and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Authenticate with database
      bool isAuthenticated = await _database.login(username, password);

      if (isAuthenticated) {
        // Save username to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);

        // Navigate to HomePage with dummy data (replace with actual data as needed)
        final dummyResults = [
          Results(
              id: 1, title: 'Dummy News 1', summary: 'Summary of dummy news'),
          Results(
              id: 2, title: 'Dummy Blog 1', summary: 'Summary of dummy blog'),
          Results(
              id: 3,
              title: 'Dummy Report 1',
              summary: 'Summary of dummy report'),
        ];

        final newsData = ClassName(results: dummyResults);
        final blogData = ClassName(results: dummyResults);
        final reportData = ClassName(results: dummyResults);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              newsData: newsData,
              blogData: blogData,
              reportData: reportData,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
