import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    void submitContact() {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final message = messageController.text.trim();

      if (name.isEmpty || email.isEmpty || message.isEmpty) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Error"),
            content: Text("All fields are required."),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
        return;
      }

      // Here you can send the data to your backend or email service
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Thank You!"),
          content: Text(
            "Dear $name, your message has been submitted successfully. We will contact you at $email.",
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
      nameController.clear();
      emailController.clear();
      messageController.clear();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 244, 248),
      appBar: AppBar(
        title: Text("Contact Us"),
        backgroundColor: Color.fromARGB(255, 169, 193, 187),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Get in Touch",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "We’d love to hear from you! If you have any questions, feedback, or suggestions, "
                "please fill out the form below or reach us directly via email or phone.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 24),

              // Name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Your Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),

              // Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Your Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),

              // Message
              TextField(
                controller: messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Your Message",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: submitContact,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                  elevation: 5,
                  backgroundColor: Colors.blue,
                ),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 30),

              Text(
                "Or contact us directly:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Email: support@timelytravel.com",
                style: TextStyle(fontSize: 16),
              ),
              Text("Phone: +91 98765 43210", style: TextStyle(fontSize: 16)),
              Text(
                "Address: 123, Travel Street, Coimbatore, India",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
