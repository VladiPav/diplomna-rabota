import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../themes/themes.dart';
import '../../../util/route_manager.dart';
import 'widgets/password_text_field.dart';
import 'widgets/register_button.dart';
import 'widgets/confirm_password_text_field.dart';
import 'widgets/email_text_field.dart';
import 'widgets/username_text_field.dart';

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