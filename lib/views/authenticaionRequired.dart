import 'package:flutter/material.dart';

class AuthenticationRequired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/homepage.JPEG'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
