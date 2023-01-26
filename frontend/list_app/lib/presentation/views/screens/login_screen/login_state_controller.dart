import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../data/repositories/auth_repository.dart';
import '../../util/route_manager.dart';


class LoginController extends StateNotifier<void> {
  LoginController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  Future<void> login(
      String email,
      String password,
      BuildContext context,
      ) async {
    print(email.toString() + '   ' + password.toString());
    await _authRepository
        .signIn(
      email: email,
      password: password,
    )
        .then(
          (value) async => await navigatorKey.currentState!
          .pushReplacementNamed(Routes.accessValidator),
    );
  }
}