import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../themes/themes.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text_fields/confirm_password_text_field.dart';
import '../custom_widgets/custom_text_fields/email_text_field.dart';
import '../custom_widgets/custom_text_fields/password_text_field.dart';
import '../custom_widgets/custom_text_fields/username_text_field.dart';
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
                CustomButton(
                  width: 155,
                  height: 50,
                  fontSize: 24,
                  text: "Register",
                  borderRadius: 100,
                  func: () => {Navigator.pushReplacementNamed(context, Routes.profile)},
                ),
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