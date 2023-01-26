import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_app/presentation/views/screens/register_screen/register_providers.dart';

import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_text_field.dart';

class UsernameTextField extends ConsumerWidget {
  const UsernameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
        inputType: TextInputType.visiblePassword,
        hintText: "",
        obscure: false,
        func: (value) => ref
            .read(
              registerUsernameControllerProvider.notifier,
            )
            .update((state) => value),
        fieldColor: customGray1,
        label: "Username");
  }
}
