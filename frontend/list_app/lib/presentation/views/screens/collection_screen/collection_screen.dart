import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/collection_model.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ModalRoute.of(context)!.settings.arguments as Collection;
    print('RESULT:\n$collection');
    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
      ),
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              collection.collectionElements.length,
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
  }
}
