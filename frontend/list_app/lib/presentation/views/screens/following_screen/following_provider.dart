import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../data/models/user_model.dart';
import '../../../common_providers/common_providers.dart';

final followersProvider = FutureProvider.autoDispose<List<User>> ((ref) async {
  return UserRepository(api: ref.read(apiProvider)).getFollowers();
},);

final followingProvider = FutureProvider.autoDispose<List<User>> ((ref) async {
  return UserRepository(api: ref.read(apiProvider)).getFollowing();
},);

