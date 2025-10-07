import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart'; // for AppConfig.baseUrl

class Suggession extends StatefulWidget {
  const Suggession({super.key});

  @override
  State<Suggession> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<Suggession> {
  final TextEditingController placeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  List<dynamic> suggestions = [];
  String message = "";
  bool isLoading = false;

  Future<void> getSuggestions(String place, String date) async {
    if (place.trim().isEmpty || date.trim().isEmpty) {
      _showAlert("Error", "Both Place and Date are required");
      return;
    }

    final url = Uri.parse("${AppConfig.baseUrl}/$place/$date");
    setState(() {
      isLoading = true;
      message = "";
      suggestions = [];
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List && data.isNotEmpty) {
          setState(() {
            suggestions = data;
            message = "";
          });
        } else {
          setState(() {
            message = data.toString(); // e.g., "No records found..."
          });
        }
      } else {
        setState(() {
          message = "Error: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        message = "Error connecting to server.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showAlert(String title, String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(msg),
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
      appBar: AppBar(title: Text("Travel Suggestions")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Place input
            TextField(
              controller: placeController,
              decoration: InputDecoration(
                labelText: "Enter Place",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),

            // Date input
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Select Date",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  dateController.text =
                      pickedDate.toIso8601String().split("T")[0];
                }
              },
            ),
            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                getSuggestions(placeController.text, dateController.text);
              },
              icon: Icon(Icons.search),
              label: Text("Search"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),

            if (isLoading) CircularProgressIndicator(),

            if (message.isNotEmpty && !isLoading)
              Text(message,
                  style: TextStyle(fontSize: 16, color: Colors.red)),

            // List of suggestions (without image)
            if (suggestions.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final sug = suggestions[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sug['place'] ?? "Unknown Place",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Date: ${sug['startdate']}",
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(
                              "Time: ${sug['starttime']} - ${sug['endtime']}",
                              style: TextStyle(color: Colors.black54),
                            ),
                            SizedBox(height: 8),
                            Text(
                              sug['description'] ?? "No description",
                              style: TextStyle(fontSize: 16),
                            ),
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
