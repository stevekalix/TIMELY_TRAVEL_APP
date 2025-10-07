import 'package:flutter/material.dart';
import 'package:front_end/Travel.dart';
import 'package:front_end/gettravel.dart';

class TravelDetail extends StatefulWidget {
  const TravelDetail({super.key});

  @override
  State<TravelDetail> createState() => _TravelDetailState();
}

class _TravelDetailState extends State<TravelDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Details"),
      ),
  
      floatingActionButton: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              heroTag: "add",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Travel()),
                );
              },
              tooltip: "Add",
              child: Icon(Icons.add),
            ),
          ),
          Positioned(
            bottom: 140,
            right: 16,
            child: FloatingActionButton(
              heroTag: "view",
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => Gettravel()),
                );
              },
              tooltip: "View",
              child: Icon(Icons.visibility),
            ),
          ),
          Positioned(
            bottom: 200,
            right: 16,
            child: FloatingActionButton(
              heroTag: "delete",
              onPressed: () {
                
              },
              tooltip: "Delete",
              child: Icon(Icons.delete),
            ),
          ),
          Positioned(
            bottom: 260,
            right: 16,
            child: FloatingActionButton(
              heroTag: "export",
              onPressed: () {
              
              },
              tooltip: "Export",
              child: Icon(Icons.share),
            ),
          ),
        ],
      ),
    );
  }
}
