import 'animated_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedButton(
          elevationValue: 10,
          height: 50,
          width: 150,
          radius: 15,
          beforeClickText: "Confirm",
          afterClickText: "Confirmed",
          buttonColor: Colors.green,
          textColor: Colors.white,
          duration: Duration(milliseconds: 5000),
          icon: Icons.check,
        ),
      ),
    );
  }
}
