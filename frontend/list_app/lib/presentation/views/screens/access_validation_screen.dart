import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:list_app/presentation/providers/auth_state_provider.dart';
import 'package:list_app/presentation/providers/repository_providers.dart';
import 'package:list_app/presentation/themes/themes.dart';
import 'package:list_app/presentation/views/login_screen/login.dart';


class AccessValidator extends ConsumerWidget {
  const AccessValidator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authServices = ref.watch(authRepositoryProvider);

    return authState.when(
      data:  (data) {
          return Text("data");
      },
      error: (e, s) => LoginScreen(),
      loading: () => const Scaffold(
        body: Center(
          child: SpinKitWave(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
