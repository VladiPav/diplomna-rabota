import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/user_repository.dart';
import 'api_service_provider.dart';

final isFollowingProvider = FutureProvider.family(
    (ref, id) => UserRepository(api: ref.read(apiProvider)).isFollowing(id),
);
