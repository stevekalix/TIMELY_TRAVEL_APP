import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Travel extends StatefulWidget {
  const Travel({super.key});

  @override
  State<Travel> createState() => _TravelPageState();
}

class _TravelPageState extends State<Travel> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String result = "";
  final String baseUrl = "http://10.0.2.2:8080"; // Spring Boot API base URL

  // Update travel by username
  Future<void> updateTravelByUsername(String username) async {
    if (username.trim().isEmpty) {
      _showAlert("Error", "Username is required");
      return;
    }

    final url = Uri.parse("$baseUrl/updateTravelByUsername/$username");
    final body = jsonEncode({
      "username": usernameController.text,
      "name": nameController.text,
      "source": sourceController.text,
      "destination": destinationController.text,
      "travelDate": dateController.text,
      "travelTime": timeController.text,
    });

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          result = "Updated Successfully!";
        });
        _showAlert("Success", "Travel updated successfully!");
      } else {
        setState(() {
          result = "Error: ${response.body}";
        });
        _showAlert("Error", "Failed to update travel: ${response.body}");
      }
    } catch (e) {
      setState(() {
        result = "Error connecting to server.";
      });
      _showAlert("Error", "Could not connect to server.");
    }
  }


  void _showAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context), child: Text("OK"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Travel Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    labelText: "Username *", border: OutlineInputBorder()),
              ),
              SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Name *", border: OutlineInputBorder()),
              ),
              SizedBox(height: 12),
              TextField(
                controller: sourceController,
                decoration:
                    InputDecoration(labelText: "Source", border: OutlineInputBorder()),
              ),
              SizedBox(height: 12),
              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                    labelText: "Destination", border: OutlineInputBorder()),
              ),
              SizedBox(height: 12),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                    labelText: "Travel Date (YYYY-MM-DD)",
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 12),
              TextField(
                controller: timeController,
                decoration: InputDecoration(
                    labelText: "Travel Time (HH:mm)", border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  updateTravelByUsername(usernameController.text);
                },
                child: Text("Save / Update Travel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






