import 'api_service_provider.dart';
import '../../data/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_model.dart';

final currentUserProvider = FutureProvider<User>(
  (ref) => UserRepository(
    api: ref.read(apiProvider),
  ).getCurrentUser(),
);
