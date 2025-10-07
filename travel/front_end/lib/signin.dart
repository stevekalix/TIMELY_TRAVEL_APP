import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/login.dart';
import 'package:http/http.dart' as http;

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup() async {
    final url = Uri.parse("http://10.0.2.2:8080/api/signup");

    final Map<String, dynamic> userJson = {
      "username": _usernameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "profile": {
        "email": _emailController.text, // Only email
      },
      "travels": [
        {"username": _usernameController.text},
      ],
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userJson),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup successful with profile email")),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${response.body}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: Text(
              "Login",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 213, 176, 176),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Sign Up", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
