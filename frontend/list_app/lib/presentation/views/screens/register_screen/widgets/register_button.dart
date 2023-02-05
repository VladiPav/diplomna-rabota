import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_app/presentation/views/custom_widgets/custom_error_alert_dialog.dart';
import 'package:list_app/presentation/views/screens/register_screen/register_providers.dart';

import '../../../custom_widgets/custom_button.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(registerEmailControllerProvider);

    final password = ref.watch(registerPasswordControllerProvider);

    final confirmPassword = ref.watch(registerConfirmPasswordControllerProvider);

    final username = ref.watch(registerUsernameControllerProvider);

    return CustomButton(
      width: 155,
      height: 50,
      fontSize: 24,
      text: "Register",
      borderRadius: 100,
      func: () async {
        if (email.trim() == '' ||
            password.trim() == '' ||
            username.trim() == '') {
          await showDialog(
            context: context,
            builder: (_) => const ErrorAlertDialog(
              errorMessage: "Fill in all fields!",
            ),
          );
          return;
        }

        if(password != confirmPassword) {
          await showDialog(
            context: context,
            builder: (_) => const ErrorAlertDialog(
              errorMessage: "Passwords must match!",
            ),
          );
          return;
        }

        await ref
            .read(registerControllerProvider.notifier)
            .register(email, password, username, context)
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
