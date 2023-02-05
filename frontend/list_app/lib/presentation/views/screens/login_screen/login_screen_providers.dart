import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_providers/repository_providers.dart';
import 'login_state_controller.dart';

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