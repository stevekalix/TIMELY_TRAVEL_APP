import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Home.dart'; // Make sure this path is correct for your project

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  bool _showForgotPassword = false;
  bool _isLoading = false;

  final TextEditingController _emailUsernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _forgotEmailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  // Login function
  Future<void> _login() async {
    setState(() => _isLoading = true);

    final url = Uri.parse("http://10.0.2.2:8080/api/login");

    final Map<String, dynamic> loginData = {
      "email": _emailUsernameController.text,
      "username": _emailUsernameController.text,
      "password": _passwordController.text,
    };



    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginData),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(

              email: _emailUsernameController.text,
              username: _emailUsernameController.text

          )),
        );
      } else {
        _showAlertDialog(
          "Login Failed",
          "Invalid credentials or user not signed up. Please Sign Up first.",
        );
      }
    } catch (e) {
      _showAlertDialog("Error", "Could not connect to server. Try again later.");
    }

    setState(() => _isLoading = false);
  }

  // Forgot password function
  Future<void> _updatePassword() async {
    final email = _forgotEmailController.text;
    final newPassword = _newPasswordController.text;

    if (email.isEmpty || newPassword.isEmpty) {
      _showAlertDialog("Error", "Please enter both email and new password");
      return;
    }

    if (newPassword.length < 6) {
      _showAlertDialog("Error", "Password must be  at least 6 characters");
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse("http://10.0.2.2:8080/api/forget/$email");
    final Map<String, String> body = {"password": newPassword};

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        _showAlertDialog("Success", "Password updated successfully");
        setState(() => _showForgotPassword = false);
      } else {
        _showAlertDialog("Failed", response.body);
      }
    } catch (e) {
      _showAlertDialog("Error", "Could not connect to server. Try again later.");
    }

    setState(() => _isLoading = false);
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(title: Text(_showForgotPassword ? "Forgot Password" : "Login")),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        
          elevation: 6,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _showForgotPassword ? _buildForgotPasswordForm() : _buildLoginForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Login",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _emailUsernameController,
          decoration: InputDecoration(
              labelText: "Username or Email",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          obscureText: true,
        ),
        SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => setState(() => _showForgotPassword = true),
            child: Text("Forgot Password?"),
          ),
        ),
        SizedBox(height: 12),
        _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Login", style: TextStyle(fontSize: 18)),
              ),
      ],
    );
  }

  Widget _buildForgotPasswordForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Reset Password",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _forgotEmailController,
          decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _newPasswordController,
          decoration: InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          obscureText: true,
        ),
        SizedBox(height: 20),
        _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _updatePassword,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Update Password", style: TextStyle(fontSize: 18)),
              ),
        TextButton(
          onPressed: () => setState(() => _showForgotPassword = false),
          child: Text("Back to Login"),
        ),
      ],
    );
  }
}
