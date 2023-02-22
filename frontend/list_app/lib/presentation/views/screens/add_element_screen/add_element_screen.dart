import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../models/collection_model.dart';
import '../../../common_providers/common_providers.dart';
import '../../../common_providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_text_field.dart';
import 'add_element_providers.dart';
import 'widgets/element_search_field.dart';

class AddElementScreen extends ConsumerWidget {
  const AddElementScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ModalRoute.of(context)?.settings.arguments as Collection;
    final elements = ref.watch(elementsProvider(collection.categoryId));
    final _isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ElementSearchTextField(),
            elements.when(
              data: (elements) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: elements.length + 1,
                      itemBuilder: (context, index) {
                        if (index == elements.length) {
                          return ListTile(
                            title: Text("Add new item"),
                            leading: Icon(Icons.add),
                            onTap: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30))),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20,
                                      MediaQuery.of(context).viewInsets.bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomTextField(
                                          inputType: TextInputType.name,
                                          hintText: 'e.g. Divine comedy',
                                          obscure: false,
                                          func: (value) => ref
                                              .read(newElementTextFieldProvider
                                                  .notifier)
                                              .update((state) => value),
                                          fieldColor: customGray1,
                                          label: 'Name'),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: ElevatedButton.icon(
                                          onPressed: _isLoading
                                              ? null
                                              : () async {
                                                  ref
                                                      .read(isLoadingProvider
                                                          .notifier)
                                                      .state = true;
                                                  await ref
                                                      .read(
                                                          elementRepositoryProvider)
                                                      .createElement(
                                                        ref.watch(
                                                            newElementTextFieldProvider),
                                                        collection.categoryId,
                                                      );
                                                  ref.invalidate(
                                                      elementsProvider);
                                                  ref
                                                      .read(isLoadingProvider
                                                          .notifier)
                                                      .state = false;
                                                  Navigator.pop(context);
                                                },
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    primaryColor),
                                          ),
                                          icon: _isLoading
                                              ? Container(
                                                  width: 24,
                                                  height: 24,
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child:
                                                      const CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 3,
                                                  ),
                                                )
                                              : const Icon(Icons.create),
                                          label: const Text(
                                            'Create Item',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return ListTile(
                          leading: Text(''),
                          title: Text(elements[index].name),
                          onTap: () async {
                            ref.read(isLoadingProvider.notifier).state = true;
                            await ref
                                .read(collectionRepositoryProvider)
                                .addElement(
                                    elements[index].id,
                                    collection.id,
                                    (collection.collectionElements.length + 1).toString());
                            ref.read(isLoadingProvider.notifier).state = false;
                            Navigator.pop(context);
                          },
                        );
                      }),
                );
              },
              error: (error, stacktrace) => Text('Error: $error'),
              loading: () => Center(
                child: SpinKitWave(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ));
  }
}
