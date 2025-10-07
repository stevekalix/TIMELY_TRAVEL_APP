import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart'; // Import AppConfig for baseUrl

class Gettravel extends StatefulWidget {
  const Gettravel({super.key});

  @override
  State<Gettravel> createState() => _GettravelState();
}

class _GettravelState extends State<Gettravel> {
  final TextEditingController nameController = TextEditingController();
  List<dynamic> travels = []; // Store list of travel objects
  String message = "";

  // Fetch travel details by name
  Future<void> getTravelByName(String name) async {
    if (name.trim().isEmpty) {
      _showAlert("Error", "Name is required");
      return;
    }

    final url = Uri.parse("${AppConfig.baseUrl}/get/$name");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          setState(() {
            travels = data;
            message = "";
          });
        } else {
          setState(() {
            travels = [];
            message = "No travel data found for this name.";
          });
        }
      } else {
        setState(() {
          travels = [];
          message = "Error: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        travels = [];
        message = "Error connecting to server.";
      });
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Travel by Name")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getTravelByName(nameController.text);
              },
              child: Text("Fetch Travel Details"),
            ),
            SizedBox(height: 20),

            // Show message if no data
            if (message.isNotEmpty) Text(message, style: TextStyle(fontSize: 16, color: Colors.red)),

            // Show data in proper cards
            Expanded(
              child: ListView.builder(
                itemCount: travels.length,
                itemBuilder: (context, index) {
                  final travel = travels[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(Icons.travel_explore, color: Colors.blue),
                      title: Text("${travel['source']} ➝ ${travel['destination']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Username: ${travel['username']}"),
                          Text("Name: ${travel['name']}"),
                          Text("Date: ${travel['travelDate']}"),
                          Text("Time: ${travel['travelTime']}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
