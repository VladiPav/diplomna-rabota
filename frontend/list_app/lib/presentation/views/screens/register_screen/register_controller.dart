import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/auth_repository.dart';
import '../../../util/route_manager.dart';

class RegisterController extends StateNotifier<void> {
  RegisterController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  void navigateToAuth() {
    navigatorKey.currentState!.pushReplacementNamed(Routes.accessValidator);
  }

  Future<void> register(
      String email,
      String password,
      String username,
      BuildContext context,
      ) async {
    await _authRepository
        .signUp(
      email: email,
      password: password,
      username: username,
    )
        .then(
          (value) => navigateToAuth(),
    );

  }
}
