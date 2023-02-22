import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../models/user_model.dart';
import '../../../../common_providers/common_providers.dart';
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
        print('COLLECTIONS:\n${user.collections}');
        return Column(
          children: [
            if (currentUser.id == user.id)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Add list',
                    width: 150,
                    height: 45,
                    fontSize: 18,
                    func: () {
                      Navigator.pushNamed(context, Routes.createCollection);
                    },
                  )
                ],
              ),
            user.collections.isNotEmpty
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: user.collections.length,
                    itemBuilder: (context, int index) {
                      final collection = user.collections[index];
                      return Card(
                        surfaceTintColor: Colors.transparent,
                        child: ListTile(
                          leading: Text('$index'),
                          title: Text(collection.name ?? 'alo'),
                          onTap: () {
                            print('COLLECTIONID:\n${collection.id}');
                            ref.read(collectionIdProvider.notifier).state =
                                collection.id;
                            Navigator.pushNamed(context, Routes.collection,
                                arguments: user);
                          },
                        ),
                      );
                    })
                : Center(child: Text('User currently has no collections')),
          ],
        );
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
