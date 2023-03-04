import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../models/collection_element_model.dart';
import '../../../../models/user_model.dart';
import '../../../common_providers/common_providers.dart';
import '../../../common_providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../../util/route_manager.dart';
import '../../custom_widgets/custom_alert_dialog.dart';
import '../../custom_widgets/custom_button.dart';
import '../add_element_screen/add_element_providers.dart';
import '../add_element_screen/widgets/element_search_field.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ModalRoute.of(context)?.settings.arguments as User;
    final collection = ref.watch(collectionProvider);
    final currentUser = ref.watch(currentUserProvider);
    return collection.when(
        data: (collection) {
          return Scaffold(
            appBar: AppBar(
              title: Text(collection.name),
            ),
            body: SafeArea(
              child: currentUser.when(
                data: (currentUser) {
                  return currentUser.id == user.id
                      ? ReorderableListView.builder(
                          header: Text(
                            'Press and hold an item to reorder',
                            textAlign: TextAlign.center,
                          ),
                          shrinkWrap: true,
                          itemCount: collection.collectionElements.length,
                          itemBuilder: (context, int index) {
                            final element =
                                collection.collectionElements[index];
                            return Card(
                              key: Key(element.elementId),
                              surfaceTintColor: Colors.transparent,
                              child: ListTile(
                                leading: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                title: Text(element.element.name),
                                trailing: user.id == currentUser.id
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: customGray1,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomAlertDialog(
                                              title: Text(
                                                'Are you sure?',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Text(
                                                'Are you sure you want to remove this item from the collection?',
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          primaryColor),
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                            collectionRepositoryProvider)
                                                        .removeElement(
                                                            element.elementId,
                                                            collection.id);
                                                    ref.invalidate(
                                                        collectionProvider);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          primaryColor),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      )
                                    : null,
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final CollectionElement item = collection
                                .collectionElements
                                .removeAt(oldIndex);
                            collection.collectionElements
                                .insert(newIndex, item);
                            ref
                                .read(collectionRepositoryProvider)
                                .reorderCollection(collection);
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: collection.collectionElements.length,
                          itemBuilder: (context, int index) {
                            final element =
                                collection.collectionElements[index];
                            return Card(
                              key: Key(element.elementId),
                              surfaceTintColor: Colors.transparent,
                              child: ListTile(
                                leading: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                title: Text(element.element.name),
                              ),
                            );
                          });
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
                    ? Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: CustomButton(
                                text: 'Add Item',
                                width: 150,
                                height: 45,
                                fontSize: 18,
                                func: () {
                                  ref.invalidate(elementTextFieldProvider);
                                  Navigator.pushNamed(
                                      context, Routes.addElement,
                                      arguments: collection);
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    : Text('');
              },
              error: (error, stacktrace) => Text('Error: $error'),
              loading: () => const Center(
                child: SpinKitWave(
                  color: primaryColor,
                ),
              ),
            ),
            extendBody: true,
          );
        },
        error: (error, stacktrace) => Text('Error: $error'),
        loading: () => Scaffold(
              body: const Center(
                child: SpinKitWave(
                  color: primaryColor,
                ),
              ),
            ));
  }
}
