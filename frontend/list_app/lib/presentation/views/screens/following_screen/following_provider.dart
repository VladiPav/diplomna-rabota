import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/api/api_service.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../models/user_model.dart';

final followersProvider = FutureProvider<List<User>> ((ref) async {
  return UserRepo(api: ref.read(apiProvider)).getFollowers();
});
