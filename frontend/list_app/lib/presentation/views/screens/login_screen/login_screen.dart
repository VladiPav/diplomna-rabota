import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../themes/themes.dart';
import '../../../util/route_manager.dart';
import 'widgets/email_text_field.dart';
import 'widgets/login_button.dart';
import 'widgets/password_text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                const Text(
                  "ListApp",
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: const [
                      LoginEmailTextField(),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      LoginPasswordTextField(),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                LoginButton(),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                const Text("Don't have an account?"),
                InkWell(
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                  onTap: () =>
                      {Navigator.pushReplacementNamed(context, Routes.register)},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
