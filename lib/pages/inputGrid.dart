import 'package:flutter/material.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataHelper.dart';
import 'package:giglee_frontend_state_management_iterations/models/dataModels.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/WrappedM2.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/WrappedM1.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/WrappedM0.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/DataManagerWidget.dart';
import 'package:giglee_frontend_state_management_iterations/widgets/DataRequestHandler.dart';

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
        DataRequestHandler(
          RequestHolder('M2/*'),
          RequestDataBuilder(
            dataItemListBuilder: (dataItemList) {
              return Column(
                children: DataManagers.fromDataItems(
                  dataItemList,
                  DataItemBuilders(
                    dataBuilder: (dataItemValue) {
                      print('DataBuilder item value:${dataItemValue}');
                      return M2WrappedWidge(dataItemValue);
                    },
                    waitingWidget: Text('Waiting M2'),
                    errorWidget: Text('Error M2'),
                  ),
                ),
              );
            },
            waitingWidget: Text('Waiting M2 Group'),
            errorWidget: Text('Error M2 Group'),
          ),
        ),
        DataRequestHandler(
          RequestHolder('M1/*'),
          RequestDataBuilder(
            dataItemListBuilder: (dataItemList) {
              return Column(
                children: DataManagers.fromDataItems(
                  dataItemList,
                  DataItemBuilders(
                    dataBuilder: (dataItemValue) =>
                        M1WrappedWidge(dataItemValue),
                    waitingWidget: Text('Waiting M1'),
                    errorWidget: Text('Error M1'),
                  ),
                ),
              );
            },
            waitingWidget: Text('Waiting M1Group'),
            errorWidget: Text('Error M1 Group'),
          ),
        ),
        DataRequestHandler(
          RequestHolder('M0/*'),
          RequestDataBuilder(
            dataItemListBuilder: (dataItemList) {
              return Column(
                children: DataManagers.fromDataItems(
                  dataItemList,
                  DataItemBuilders(
                    dataBuilder: (dataItemValue) =>
                        M0WrappedWidge(dataItemValue),
                    waitingWidget: Text('Waiting M0'),
                    errorWidget: Text('Error M0'),
                  ),
                ),
              );
            },
            waitingWidget: Text('Waiting M0 Group'),
            errorWidget: Text('Error M0 Group'),
          ),
        ),
      ],
    ));
  }
}
