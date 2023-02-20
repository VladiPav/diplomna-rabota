import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../themes/themes.dart';
import 'choose_category_providers.dart';
import 'widgets/category_search_field.dart';

class ChooseCategoryScreen extends ConsumerWidget {
  const ChooseCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CategorySearchTextField(),
              categories.when(
                data: (categories) {
                  print('CATEGORIES:\n${categories.length}');
                  return categories.length != 0
                      ? Center(
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
                                    ref
                                        .read(chosenCategoryProvider.notifier)
                                        .state = categories[index];
                                    Navigator.pop(context);
                                  },
                                );
                              }),
                        )
                      : Center(child: Text('No matching categories'));
                },
                error: (error, stacktrace) => Text('Error: $error'),
                loading: () => Center(
                  child: SpinKitWave(
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
