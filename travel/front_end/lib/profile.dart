import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _isLoading = false;

  Future<void> _updateProfile() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showAlertDialog("Error", "Email cannot be empty");
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse("http://10.0.2.2:8080/updateProfile/$email");
    final body = {
      "email": email,
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "address": _addressController.text,
      "city": _cityController.text,
      "state": _stateController.text,
      "gender": _genderController.text,
      "dob": _dobController.text,
    };

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        _showAlertDialog("Success", "Profile updated successfully");
      } else {
        _showAlertDialog("Error", response.body);
      }
    } catch (e) {
      _showAlertDialog("Error", "Could not connect to server.");
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
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: "First Name"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: "Last Name"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: "Address"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: "City"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _stateController,
                  decoration: InputDecoration(labelText: "State"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: "Gender"),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: "DOB (YYYY-MM-DD)"),
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text("Add Profile", style: TextStyle(fontSize: 18)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
