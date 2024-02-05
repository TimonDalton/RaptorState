import 'package:flutter/material.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataHelper.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataModels.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/M2Widget.dart';

class DataDisplay extends StatefulWidget {
  const DataDisplay({super.key});

  @override
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  @override
  void initState() {
    super.initState();
    print('top of dataDisplay InitState');
    LocalDataStore.rondomlyChange();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(child: Text('Eyo')));
  }
}
