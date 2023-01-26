import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import '../views/util/route_manager.dart';

class UserRegisterController extends StateNotifier<void> {
  UserRegisterController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(null);
  final AuthRepository _authRepository;

  void navigateToAuth() {
    navigatorKey.currentState!.pushReplacementNamed(Routes.accessValidator);
  }

  void navigateToLogin() {
    navigatorKey.currentState!.pushReplacementNamed(Routes.login);
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
          (value) => _authRepository.getCurrentUser()!.sendEmailVerification(),
    )
        .then(
          (value) => navigateToAuth(),
    );
  }
}
