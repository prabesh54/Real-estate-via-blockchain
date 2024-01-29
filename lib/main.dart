import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'firebase_options.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(), // Set the WelcomePage as the initial page
      debugShowCheckedModeBanner: false, // Add this line to remove the debug banner
    );
  }
}
