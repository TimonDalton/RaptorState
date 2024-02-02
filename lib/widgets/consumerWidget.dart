import 'package:flutter/material.dart';
import '../models/loadable.dart';
import 'package:provider/provider.dart';

class ConsumerWidget<T> extends StatelessWidget {
  final ConsumerBuilders builders;
  final Loadable loadable;
  ConsumerWidget({required this.builders, required this.loadable});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadableService>(builder: (context, loadableService, _) {
      if (loadable.helper == null) {
        return builders.errorBuilder();
      } else if (loadable.value == null) {
        return builders.loadingBuilder();
      } else if (loadable.value != null) {
        return builders.loadedBuilder(loadable);
      } else {
        return builders.errorBuilder();
      }
    });
  }
}

// ConsumerWidget createMaintainedWidget(
//     String apiURI, ConsumerBuilders builders) {
//   return ConsumerWidget(builders: builders, loadable: getLoadable(apiURI));
// }

class ConsumerBuilders<T> {
  Widget Function(T data) loadedBuilder;
  Widget Function() loadingBuilder;
  Widget Function() errorBuilder;
  ConsumerBuilders({
    required this.loadedBuilder,
    required this.loadingBuilder,
    required this.errorBuilder,
  });
}
