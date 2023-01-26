import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/login_screen_providers.dart';
import '../../custom_alert_dialogs/variants/custom_error_alert_dialog.dart';
import '../custom_button.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(loginEmailControllerProvider);
    final password = ref.watch(loginPasswordControllerProvider);

    return CustomButton(
      width: 155,
      height: 50,
      fontSize: 24,
      text: "Log In",
      borderRadius: 100,
      func: () async {
        if (email.trim() == '' && password.trim() == '') {
          await showDialog(
            context: context,
            builder: (_) =>
                const ErrorAlertDialog(errorMessage: "Fill in all fields!"),
          );
          return;
        }

        await ref
            .read(loginControllerProvider.notifier)
            .login(email, password, context)
            .catchError(
              (error) => showDialog(
                context: context,
                builder: (_) => ErrorAlertDialog(
                  errorMessage: error.toString(),
                ),
              ),
            );
      },
    );
  }
}
