import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../add_element_providers.dart';

class ElementSearchTextField extends ConsumerWidget {
  const ElementSearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
      inputType: TextInputType.name,
      hintText: "e.g. Harry Potter and the deathly hallows",
      obscure: false,
      func: (value) =>
          ref.read(elementTextFieldProvider.notifier).update((state) => value),
      fieldColor: customGray1,
      label: "Item name",
    );
  }
}
