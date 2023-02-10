import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../models/user_model.dart';
import '../../../common_providers/apiServiceProvider.dart';

final followersProvider = FutureProvider<List<User>> ((ref) async {
  return UserRepo(api: ref.read(apiProvider)).getFollowers();
},);

final followingProvider = FutureProvider<List<User>> ((ref) async {
  return UserRepo(api: ref.read(apiProvider)).getFollowing();
},);

final searchFieldControllerProvider = StateProvider.autoDispose<String>(
      (ref) => '',
);

final searchResultsProvider = FutureProvider<List<User>>((ref) async {
  try {
    final username = ref.read(searchFieldControllerProvider);
    final response = await ref.read(apiProvider).searchUser(username);
    return response;
  } catch (e) {
    print(e);
    return [];
  }
});
