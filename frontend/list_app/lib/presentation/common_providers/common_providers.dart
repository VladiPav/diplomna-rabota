import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api/api_service.dart';
import '../../data/models/collection_model.dart';
import '../../data/models/user_model.dart';
import 'repository_providers.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());

final bottomNavigationBarStateProvider = StateProvider((ref) => null);

final collectionIdProvider = StateProvider<String>(
      (ref) => '',
);

final collectionProvider = FutureProvider.autoDispose<Collection>(
      (ref) => ref
      .read(collectionRepositoryProvider)
      .getCollectionById(ref.watch(collectionIdProvider)),
);

final currentUserProvider = FutureProvider.autoDispose<User>(
      (ref) => ref.read(userRepositoryProvider).getCurrentUser(),
);

final isFollowingProvider = FutureProvider.autoDispose.family(
      (ref, id) => ref.read(userRepositoryProvider).isFollowing(id),
);

final ScreenUserProvider = Provider<User?>(
        (ref) => null,
);

final isLoadingProvider = StateProvider<bool>(
      (ref) => false,
);
