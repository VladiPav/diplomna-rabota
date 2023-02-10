import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import 'apiServiceProvider.dart';
import 'auth_state_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>(
      (ref) => AuthRepository(
    ref.read(firebaseAuthProvider),
    ref.read(apiProvider),
  ),
);