import 'package:flutter/material.dart';
import '../models/dataModels.dart';

class M2Widge extends StatelessWidget {
  final M2 m2;
  M2Widge({required this.m2});

  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width / 100.00;
    return InkWell(
      onHover: (value) {},
      child: Container(
        width: 8 * vw,
        height: 8 * vw,
        color: Colors.blue,
      ),
    );
  }
}
