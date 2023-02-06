import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:list_app/presentation/common_providers/auth_state_provider.dart';
import 'package:list_app/presentation/common_providers/repository_providers.dart';
import 'package:list_app/presentation/themes/themes.dart';
import 'package:list_app/presentation/views/screens/profile_screen/profile_screen.dart';

import '../login_screen/login_screen.dart';


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
          if(data == null) {
            return const LoginScreen();
          }
          return const ProfileScreen();
      },
      error: (e, s) => const LoginScreen(),
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
