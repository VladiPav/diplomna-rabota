import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_providers/repository_providers.dart';
import 'register_controller.dart';

final registerEmailControllerProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final registerPasswordControllerProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final registerConfirmPasswordControllerProvider =
    StateProvider.autoDispose<String>(
  (ref) => '',
);

final registerUsernameControllerProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final registerControllerProvider =
    StateNotifierProvider.autoDispose<RegisterController, void>(
  (ref) => RegisterController(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);
