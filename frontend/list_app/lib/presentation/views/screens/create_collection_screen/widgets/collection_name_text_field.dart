import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../create_collection_providers.dart';

class CollectionNameTextField extends ConsumerWidget {
  const CollectionNameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
      inputType: TextInputType.name,
      hintText: "e.g. Favorite books",
      obscure: false,
      func: (value) => ref
          .read(collectionNameTextFieldProvider.notifier)
          .update((state) => value),
      fieldColor: customGray1,
      label: "Collection name",
    );
  }
}
