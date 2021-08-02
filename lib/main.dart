import 'package:flutter/material.dart';
import 'Screens/WelcomeScreen.dart';
import 'Screens/CodeConfirm.dart';
import 'Screens/Dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      theme: ThemeData.dark(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) =>WelcomeScreen(),
        Code.id: (context) => Code(),
        Dashboard.id: (context) => Dashboard()
      },
    );
  }
}

