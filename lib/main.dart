import 'package:flutter/material.dart';
import 'package:giglee_frontend_state_management_iterations/onAppInit.dart';
import 'package:giglee_frontend_state_management_iterations/pages/homepage.dart';
import 'global.dart';

void main() {
  onInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
