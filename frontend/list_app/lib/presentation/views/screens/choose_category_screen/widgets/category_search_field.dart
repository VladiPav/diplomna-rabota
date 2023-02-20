import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../choose_category_providers.dart';

class CategorySearchTextField extends ConsumerWidget {
  const CategorySearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
      inputType: TextInputType.name,
      hintText: "e.g. Favorite books",
      obscure: false,
      func: (value) => ref
          .read(categoryTextFieldProvider.notifier)
          .update((state) => value),
      fieldColor: customGray1,
      label: "Category name",
    );
  }
}
