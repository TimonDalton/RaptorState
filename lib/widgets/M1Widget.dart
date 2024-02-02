import 'package:flutter/material.dart';
import '../models/dataModels.dart';

class M1Widge extends StatelessWidget {
  final M1 m1;
  M1Widge({required this.m1});

  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width / 100.00;
    return InkWell(
      onHover: (value) {},
      child: Container(
        width: 8 * vw,
        height: 8 * vw,
        color: Colors.red,
      ),
    );
  }
}
