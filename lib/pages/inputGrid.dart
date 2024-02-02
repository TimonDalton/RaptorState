import 'package:flutter/material.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataModels.dart';
import '../widgets/consumerWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Wrap(
      children: [
        // ConsumerWidget(builders: ConsumerBuilders<M1>())
      ],
    ));
  }
}
