import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../common_providers/common_providers.dart';
import '../../../common_providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_text_field.dart';
import 'choose_category_providers.dart';
import 'widgets/category_search_field.dart';

class ChooseCategoryScreen extends ConsumerWidget {
  const ChooseCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final _isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            CategorySearchTextField(),
            categories.when(
              data: (categories) {
                print('CATEGORIES:\n${categories.length}');
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length + 1,
                      itemBuilder: (context, index) {
                        if (index == categories.length) {
                          return ListTile(
                            title: Text("Add new category"),
                            leading: Icon(Icons.add),
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          CustomTextField(
                                              inputType: TextInputType.name,
                                              hintText: 'e.g. Movies',
                                              obscure: false,
                                              func: (value) => ref
                                                  .read(
                                                      newCategoryTextFieldProvider
                                                          .notifier)
                                                  .update((state) => value),
                                              fieldColor: customGray1,
                                              label: 'Name'),
                                          ElevatedButton.icon(
                                            onPressed: _isLoading
                                                ? null
                                                : () async {
                                                    ref
                                                        .read(isLoadingProvider
                                                            .notifier)
                                                        .state = true;
                                                    await ref
                                                        .read(
                                                            categoryRepositoryProvider)
                                                        .createCategory(
                                                          ref.watch(
                                                              newCategoryTextFieldProvider),
                                                        );
                                                    ref.invalidate(
                                                        categoriesProvider);
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
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child:
                                                        const CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 3,
                                                    ),
                                                  )
                                                : const Icon(Icons.create),
                                            label: const Text(
                                              'Create Category',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                          );
                        }
                        return ListTile(
                          leading: Text(''),
                          title: Text(categories[index].name),
                          onTap: () {
                            ref.read(chosenCategoryProvider.notifier).state =
                                categories[index];
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
