import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_end/Signin.dart';
import 'package:front_end/login.dart';
import 'package:url_launcher/url_launcher.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 171, 201, 193),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 171, 201, 193),
        actions: [
          ElevatedButton(
            onPressed: () {
              Timer(Duration(seconds: 1), () {});
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              minimumSize: Size(55, 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: Colors.blue, // Button color
            ),
            child: Text(
              "LogIn",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          SizedBox(width: 5, height: 1),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signin()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              minimumSize: Size(57, 35),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: Colors.blue,
            ),
            child: Text(
              "SignIn",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
        title: Text(
          "Timely Travel",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: 400,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.black, width: 0),
              ),
              child: ListView(
                padding: EdgeInsets.only(top: 20),
                children: [
                  Card(
                    elevation: 15, // shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(2),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.black, width: 0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              14,
                              13,
                              13,
                            ).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: 400,
                      height: 520,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Travel Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    "https://picsum.photos/300/150?travel", // sample travel image
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),

                                // Travel Title
                                Text(
                                  "Trip to Ooty",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 5),

                                // Travel Details
                                Text("Date: 15 Oct 2025"),
                                Text("Duration: 3 Days / 2 Nights"),
                                Text(
                                  "Price: ₹4,500 per person",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30), // space between boxes
                  Card(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight:Radius.circular(12),bottomLeft: Radius.circular(12)),
          ),
          child: Container(
            width: 320,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Optional: App Logo
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        "https://picsum.photos/200"), // Replace with your logo
                  ),
                ),
                SizedBox(height: 16),

                // About Section
                Text(
                  "About App",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Timely Travel is a user-friendly app to book trips and manage travel plans efficiently. You can view bookings, get trip details, and contact support easily.",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 60),
                Divider(color: Colors.grey[300], thickness: 1),

                // Contact Section
                SizedBox(height: 8),
                Text(
                  "App Owner",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("Name: Manikandan", style: TextStyle(fontSize: 14)),
                SizedBox(height: 4),

                // Email link
                InkWell(
                  onTap: () => _launchUrl("mailto:msr962005@gmail.com"),
                  child: Text(
                    "Email: msr962005@gmail.com",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 4),

                // GitHub link
                InkWell(
                  onTap: () => _launchUrl("https://github.com/stevekalix"),
                  child: Text(
                    "GitHub: stevekalix",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 4),

                Text("Phone: +91 7094472460", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),

                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  


 void _launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
} 
  
}
