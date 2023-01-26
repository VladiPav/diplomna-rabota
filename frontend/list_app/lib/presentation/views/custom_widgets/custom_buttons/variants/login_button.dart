import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_app/presentation/views/custom_widgets/custom_alert_dialogs/custom_error_alert_dialog.dart';
import 'package:list_app/presentation/views/login_screen/controllers/login_screen_providers.dart';

import '../../custom_widgets/custom_button.dart';
import '../../util/route_manager.dart';

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
