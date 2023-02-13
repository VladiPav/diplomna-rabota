import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';
import 'api_service_provider.dart';
import 'auth_state_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>(
      (ref) => AuthRepository(
    ref.read(firebaseAuthProvider),
    ref.read(apiProvider),
  ),
);

final userRepositoryProvider = Provider<UserRepository>(
    (ref) => UserRepository(api: ref.read(apiProvider)),
);
