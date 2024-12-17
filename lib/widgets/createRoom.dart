import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Createroom extends StatelessWidget {
  const Createroom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print("room created");
      },
      child: Icon(Icons.add),
      backgroundColor: Color.fromARGB(255, 241, 131, 245),
    );
  }
}
