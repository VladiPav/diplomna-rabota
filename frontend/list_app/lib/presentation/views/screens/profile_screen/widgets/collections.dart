import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../models/collection_model.dart';
import '../../../../../models/user_model.dart';
import '../../../../common_providers/current_user_provider.dart';
import '../../../../themes/themes.dart';
import '../../../../util/route_manager.dart';
import '../../../custom_widgets/custom_button.dart';

class CollectionsWidget extends ConsumerWidget {
  final User user;
  const CollectionsWidget({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return currentUser.when(
      data: (currentUser) {
        return user.collections.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: user.collections.length,
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    currentUser.id == user.id
                        ? CustomButton(
                            text: 'Add category',
                            width: 100,
                            height: 40,
                            fontSize: 14,
                            func: () {})
                        : null;
                  }
                  final collection = user.collections[index];
                  return ListTile(
                    leading: Text('$index'),
                    title: Text(collection.name ?? 'alo'),
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.collection,
                      arguments: collection as Collection,
                    ),
                  );
                })
            : Center(child: Text('User currently has no collections'));
      },
      error: (error, stacktrace) => Text('Error: $error'),
      loading: () => Center(
        child: SpinKitWave(
          color: primaryColor,
        ),
      ),
    );
  }
}
