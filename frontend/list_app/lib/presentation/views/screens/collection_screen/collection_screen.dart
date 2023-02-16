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
    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
      ),
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              collection.elements == null ? 0 : collection.elements?.length,
          itemBuilder: (context, int index) {
            final element = collection.elements?[index];
            return ListTile(
              title: Text('alo'),
            );
          },
        ),
      ),
    );
  }
}
