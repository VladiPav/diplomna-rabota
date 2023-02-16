import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../models/collection_model.dart';
import '../../../common_providers/collection_provider.dart';
import '../../../themes/themes.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(collectionProvider);
    print('RESULT:\n$collection');
    return collection.when(
      data: (collection) {
        return Scaffold(
          appBar: AppBar(
            title: Text(collection.name),
          ),
          body: SafeArea(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: collection.collectionElements.length,
              itemBuilder: (context, int index) {
                final element = collection.collectionElements[index];
                return ListTile(
                  leading: Text('$index'),
                  title: Text(element.element.name),
                );
              },
            ),
          ),
        );
      },
      error: (error, stacktrace) => Text('Error: $error'),
      loading: () => const Center(
        child: SpinKitWave(
          color: primaryColor,
        ),
      ),
    );
  }
}
