import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api/api_service.dart';
import '../../data/repositories/user_repository.dart';
import '../../models/collection_model.dart';
import '../../models/user_model.dart';
import 'repository_providers.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());

final bottomNavigationBarStateProvider = StateProvider((ref) => null);

final collectionIdProvider = StateProvider<String>(
      (ref) => '',
);

final collectionProvider = FutureProvider<Collection>(
      (ref) => ref
      .read(collectionRepositoryProvider)
      .getCollectionById(ref.watch(collectionIdProvider)),
);

final currentUserProvider = FutureProvider.autoDispose<User>(
      (ref) => ref.read(userRepositoryProvider).getCurrentUser(),
);

final isFollowingProvider = FutureProvider.family(
      (ref, id) => ref.read(userRepositoryProvider).isFollowing(id),
);

final ScreenUserProvider = Provider<User?>(
        (ref) => null
);