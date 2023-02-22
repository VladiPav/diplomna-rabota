import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/category_repository.dart';
import '../../data/repositories/collection_repository.dart';
import '../../data/repositories/element_repository.dart';
import '../../data/repositories/user_repository.dart';
import 'auth_state_provider.dart';
import 'common_providers.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.read(firebaseAuthProvider),
    ref.read(apiProvider),
  ),
);

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(api: ref.read(apiProvider)),
);

final collectionRepositoryProvider = Provider<CollectionRepository>(
  (ref) => CollectionRepository(api: ref.read(apiProvider)),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(api: ref.read(apiProvider)),
);

final elementRepositoryProvider = Provider<ElementRepository>(
    (ref) => ElementRepository(api: ref.read(apiProvider)),
);
