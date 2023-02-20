import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../models/user_model.dart';
import '../../../common_providers/collection_provider.dart';
import '../../../common_providers/current_user_provider.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_button.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('ARGUMENTS:\n${ModalRoute.of(context)?.settings.arguments}');
    final user = ModalRoute.of(context)?.settings.arguments as User;
    print('USER:\n$user');
    final collection = ref.watch(collectionProvider);
    final currentUser = ref.watch(currentUserProvider);
    print('RESULT:\n$collection');
    return collection.when(
      data: (collection) {
        return Scaffold(
            appBar: AppBar(
              title: Text(collection.name),
            ),
            body: SafeArea(
              child: currentUser.when(
                data: (currentUser) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: currentUser.id == collection.userId
                        ? collection.collectionElements.length + 1
                        : collection.collectionElements.length,
                    itemBuilder: (context, int index) {
                      if (index == collection.collectionElements.length &&
                          currentUser.id == collection.userId) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        );
                      }
                      final element = collection.collectionElements[index];
                      return ListTile(
                        leading: Text('${index + 1}'),
                        title: Text(element.element.name),
                      );
                    },
                  );
                },
                error: (error, stacktrace) => Text('Error: $error'),
                loading: () => const Center(
                  child: SpinKitWave(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: currentUser.when(
              data: (currentUser) {
                return currentUser.id == user.id
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: 'Add Item',
                            width: 150,
                            height: 45,
                            fontSize: 18,
                            func: () {},
                          )
                        ],
                      )
                    : Text('');
              },
              error: (error, stacktrace) => Text('Error: $error'),
              loading: () => const Center(
                child: SpinKitWave(
                  color: primaryColor,
                ),
              ),
            ));
      },
      error: (error, stacktrace) => Text('Error: $error'),
      loading: () => const Center(
        child: SpinKitWave(
          color: primaryColor,
        ),
      ),
    );
  }
}
