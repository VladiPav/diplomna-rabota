import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_app/presentation/views/screens/register_screen/register_providers.dart';

import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_text_field.dart';



class EmailTextField extends ConsumerWidget {
  const EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
      inputType: TextInputType.emailAddress,
      hintText: "",
      obscure: false,
      func: (value) => ref
          .read(registerEmailControllerProvider.notifier)
          .update((state) => value),
      fieldColor: customGray1,
      label: "Email",

    );
  }
}
