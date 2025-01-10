// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'waste_classifier.dart';  // Import the waste classifier page
// import 'screens/HomeScreen.dart';
//
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   String _errorMessage = "";
//
//   // Login function - checks user credentials from SharedPreferences
//   Future<void> _login() async {
//     final prefs = await SharedPreferences.getInstance();
//     final email = _emailController.text;
//     final password = _passwordController.text;
//
//     // Check if the user is already saved in SharedPreferences
//     String? storedEmail = prefs.getString('email');
//     String? storedPassword = prefs.getString('password');
//
//     bool isValidUser = false;
//     bool isNewUser = false;
//
//     if (storedEmail != null && storedPassword != null) {
//       // If user already exists, check credentials
//       if (storedEmail == email && storedPassword == password) {
//         isValidUser = true;
//       }
//     } else {
//       // If the user doesn't exist, add the new user to SharedPreferences
//       await prefs.setString('email', email);
//       await prefs.setString('password', password);
//       isNewUser = true;
//     }
//
//     if (isValidUser || isNewUser) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     } else {
//       setState(() {
//         _errorMessage = "Invalid email or password.";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//             if (_errorMessage.isNotEmpty) ...[
//               SizedBox(height: 10),
//               Text(
//                 _errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/HomeScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = "";

  Future<void> _login() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _errorMessage = "Email and password cannot be empty.";
        });
        return;
      }

      // Retrieve stored credentials
      final storedEmail = prefs.getString('email');
      final storedPassword = prefs.getString('password');

      if (storedEmail == null || storedPassword == null) {
        // No credentials found; save the new user details
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        return;
      }

      // Check if entered credentials match the stored ones
      if (storedEmail == email && storedPassword == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Show error if credentials do not match
        setState(() {
          _errorMessage = "Invalid email or password.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An unexpected error occurred.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            if (_errorMessage.isNotEmpty) ...[
              SizedBox(height: 10),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
