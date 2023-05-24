import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../data/models/user_model.dart';
import '../../../../common_providers/common_providers.dart';
import '../../../../common_providers/repository_providers.dart';
import '../../../../themes/themes.dart';
import '../../../../util/route_manager.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
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
      data: (currentUser) => Column(
          children: [
            if (currentUser.id == user.id)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Add list',
                    // width: 150,
                    // height: 45,
                    fontSize: 18,
                    func: () {
                      Navigator.pushNamed(context, Routes.createCollection);
                    },
                  )
                ],
              ),
            if (user.collections.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: user.collections.length,
                itemBuilder: (context, int index) {
                  final collection = user.collections[index];
                  return Card(
                    surfaceTintColor: Colors.transparent,
                    child: ListTile(
                      leading: Text('${collection.collectionElements.length}'),
                      title: Text(collection.name ?? 'alo'),
                      trailing: user.id == currentUser.id
                          ? IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: customGray1,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomAlertDialog(
                                    title: const Text(
                                      'Are you sure?',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: const Text(
                                      'Are you sure you want to delete this collection?',
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor: primaryColor),
                                        onPressed: () async {
                                          await ref
                                              .read(
                                                  collectionRepositoryProvider)
                                              .deleteCollection(collection.id);
                                          ref.invalidate(currentUserProvider);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor: primaryColor),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                );
                              },
                            )
                          : null,
                      onTap: () {
                        ref.read(collectionIdProvider.notifier).state =
                            collection.id;
                        Navigator.pushNamed(
                          context,
                          Routes.collection,
                          arguments: user,
                        );
                      },
                    ),
                  );
                },
              )
            else
              const Center(child: Text('User currently has no collections')),
          ],
        ),
      error: (error, stacktrace) => Text('Error: $error'),
      loading: () => const Center(
        child: SpinKitWave(
          color: primaryColor,
        ),
      ),
    );
  }
}
