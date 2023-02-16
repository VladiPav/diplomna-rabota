import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/collection_model.dart';
import '../../../../../models/user_model.dart';
import '../../../../common_providers/current_user_provider.dart';
import '../../../../util/route_manager.dart';

class CollectionsWidget extends ConsumerWidget {
  final User user;
  const CollectionsWidget({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return user.collections!.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: user.collections?.length == null
            ? 0
            : (user.collections?.length)! + 1,
        itemBuilder: (context, int index) {
          final collection = user.collections?[index];
          return ListTile(
            leading: Text('$index'),
            title: Text(collection?.name ?? 'alo'),
            onTap: () => Navigator.pushNamed(
              context,
              Routes.collection,
              arguments: collection as Collection,
            ),
          );
        }) : Center(child: Text('User currently has no collections'));
  }
}
