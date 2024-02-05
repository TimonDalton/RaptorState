import 'package:flutter/material.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataModels.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/M2Widget.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/M1Widget.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/M0Widget.dart';

class InputGrid extends StatefulWidget {
  const InputGrid({super.key});

  @override
  State<InputGrid> createState() => _InputGridState();
}

class _InputGridState extends State<InputGrid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Wrap(
      children: [
        M2Widge(m2: M2(value: '1')),
        M2Widge(m2: M2(value: '2')),
        M2Widge(m2: M2(value: '3')),
        M1Widge(
            m1: M1(value: [
          M1_Child(value: 1),
          M1_Child(value: 2),
          M1_Child(value: 3),
          M1_Child(value: 4)
        ])),
        M0Widge(
            m0: M0(value: [
          M0_Child(value: [
            M0_GrandChild(value: 1),
            M0_GrandChild(value: 2),
            M0_GrandChild(value: 3),
          ]),
          M0_Child(value: [
            M0_GrandChild(value: 5),
            M0_GrandChild(value: 6),
            M0_GrandChild(value: 7),
          ]),
          M0_Child(value: [
            M0_GrandChild(value: 8),
            M0_GrandChild(value: 9),
            M0_GrandChild(value: 4),
          ]),
        ])),
        // ConsumerWidget(builders: ConsumerBuilders<M1>())
      ],
    ));
  }
}
