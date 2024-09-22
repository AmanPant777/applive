import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Sans Serif",
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:  const Color(0xFFE3712E), // Button color
        foregroundColor: Colors.white, // Text color
      ),
    ),
          primaryColor: const Color(0xFFE3712E),
          primaryColorDark: const Color(0xFF212121),
          primaryColorLight: const Color(0xFFE5E3E0),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFE3712E),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFE3712E),
            shadowColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: false,
            scrolledUnderElevation: 10.0,
            toolbarHeight: 72.0,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.normal),
            actionsIconTheme: IconThemeData(color: Colors.white, size: 16.0),
          ),
          textTheme: const TextTheme(
              headlineLarge:
                  TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
              headlineMedium:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              headlineSmall:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              bodyMedium: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(66, 71, 71, 71)))),
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistrationScreen({super.key});

  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersString = prefs.getString('users');
    Map<String, String> users = usersString != null
        ? Map<String, String>.from(jsonDecode(usersString))
        : {};

    // Add the new user credentials to the map
    users[_usernameController.text] = _passwordController.text;

    // Save the updated map back to SharedPreferences
    await prefs.setString('users', jsonEncode(users));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Create Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Create Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveCredentials();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Credentials Saved!')),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersString = prefs.getString('users');
    Map<String, String> users = usersString != null
        ? Map<String, String>.from(jsonDecode(usersString))
        : {};

    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    if (users.containsKey(enteredUsername) &&
        users[enteredUsername] == enteredPassword) {
      // Navigate to SuccessScreen if credentials are correct
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()),
      );
    } else {
      // Show an error message if the credentials do not match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Enter Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Enter Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
             
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: const Center(
        child: Text(
          'Login Successful',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
