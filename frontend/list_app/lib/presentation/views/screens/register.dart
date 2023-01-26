import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../themes/themes.dart';
import '../custom_widgets/custom_buttons/custom_button.dart';
import '../custom_widgets/custom_buttons/variants/register_button.dart';
import '../custom_widgets/custom_text_fields/variants/confirm_password_text_field.dart';
import '../custom_widgets/custom_text_fields/variants/email_text_field.dart';
import '../custom_widgets/custom_text_fields/variants/password_text_field.dart';
import '../custom_widgets/custom_text_fields/variants/username_text_field.dart';
import '../util/route_manager.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: const [
                      EmailTextField(),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      UsernameTextField(),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      PasswordTextField(),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      ConfirmPasswordTextField(),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                RegisterButton(),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                const Text("Already have an account?"),
                InkWell(
                  child: const Text(
                    "Log In",
                    style: TextStyle(color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () =>
                  {Navigator.pushReplacementNamed(context, Routes.login)},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}