import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_model.dart';
import 'repository_providers.dart';

final currentUserProvider = FutureProvider<User>(
  (ref) => ref.read(userRepositoryProvider).getCurrentUser(),
);
