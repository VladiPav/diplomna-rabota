import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../models/user_model.dart';
import '../../../common_providers/api_service_provider.dart';

final followersProvider = FutureProvider<List<User>> ((ref) async {
  return UserRepository(api: ref.read(apiProvider)).getFollowers();
},);

final followingProvider = FutureProvider<List<User>> ((ref) async {
  return UserRepository(api: ref.read(apiProvider)).getFollowing();
},);

