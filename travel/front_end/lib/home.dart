import 'package:flutter/material.dart';
import 'package:front_end/Contact.dart';
import 'package:front_end/profile.dart';
import 'package:front_end/sugession.dart'; // Suggestion page
import 'package:front_end/travel.dart';

class Home extends StatefulWidget {
  final String username;
  final String email;

  const Home({super.key, required this.username, required this.email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 239, 238),
      appBar: AppBar(

        actions: [
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                
                },
            ),
        ],
        title: Text("Home"),
        backgroundColor: Color.fromARGB(255, 178, 224, 213),
      ),

      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          // Travel Card
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Travel()),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.travel_explore, color: Colors.blue),
                title: Text("Travel"),
                subtitle: Text("Plan your trip details here."),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ),
          SizedBox(height: 12),

          // Suggestion Card
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Suggession()),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.lightbulb, color: Colors.orange),
                title: Text("Suggestion"),
                subtitle: Text("Get suggestions for better travel."),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.username),
              accountEmail: Text(widget.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 70, 111, 102),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home", style: TextStyle(fontSize: 20)),
              onTap: () => Navigator.pop(context),
            ),
        
            Divider(height: 10, color: const Color.fromARGB(255, 158, 151, 151)),
    
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About", style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutPage()),
                );
              },
            ),
            Divider(height: 10, color: const Color.fromARGB(255, 158, 151, 151)),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile", style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Profile()),
                );
              },
            ),
            Divider(height: 10, color: const Color.fromARGB(255, 158, 151, 151)),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("Contact", style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Contact()),
                );
              },
            ),
            Divider(height: 10, color: const Color.fromARGB(255, 158, 151, 151)),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings", style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            Divider(height: 10, color: const Color.fromARGB(255, 158, 151, 151)),

            ListTile(
              leading: Icon(Icons.info),
              title: Text("Info", style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            Divider(height: 10, color: const Color.fromARGB(255, 158, 151, 151)),
          ],
        ),
      ),
    );
  }
}

// -------- About Page ----------
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: Color.fromARGB(255, 234, 239, 238),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Timely Travel!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Timely Travel is your personal travel planning assistant. "
                "With this app, you can:\n\n"
                "• Plan and manage your travel details, including source, destination, date, and time.\n"
                "• Get travel suggestions to make your trips more convenient and enjoyable.\n"
                "• Keep track of all your trips in one place for easy access.\n\n"
                "Our goal is to make your travel experience smooth and stress-free. "
                "We provide timely information and suggestions to help you make the best travel decisions.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                "Happy Traveling!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
