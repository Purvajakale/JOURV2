import 'package:flutter/material.dart';

class AuthenticationRequired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Center(
            child: Text('Authenticating...',
                style: TextStyle(color: Colors.blueAccent, fontSize: 50)),
          ),
        ),
      ),
    );
  }
}
