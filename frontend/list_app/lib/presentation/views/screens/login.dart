import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:list_app/presentation/views/login_screen/widgets/login_button.dart';

import '../../themes/themes.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text_fields/email_text_field.dart';
import '../custom_widgets/custom_text_fields/password_text_field.dart';
import '../util/route_manager.dart';

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
                SpinKitWave(
                  color: primaryColor,
                  size: 60,
                ),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: const [
                      EmailTextField(),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      PasswordTextField(),
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
