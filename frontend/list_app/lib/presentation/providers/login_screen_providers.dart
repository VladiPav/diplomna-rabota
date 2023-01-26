import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/login_state_controller.dart';
import 'repository_providers.dart';

final loginEmailControllerProvider =
StateProvider.autoDispose<String>((ref) => '');
final loginPasswordControllerProvider =
StateProvider.autoDispose<String>((ref) => '');
final loginControllerProvider = StateNotifierProvider<LoginController, void>(
      (ref) => LoginController(
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);
