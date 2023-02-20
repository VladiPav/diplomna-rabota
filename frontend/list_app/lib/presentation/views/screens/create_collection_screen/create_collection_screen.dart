import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../../util/route_manager.dart';
import '../../custom_widgets/custom_button.dart';
import '../choose_category_screen/choose_category_providers.dart';
import 'create_collection_providers.dart';
import 'widgets/collection_name_text_field.dart';

final isLoadingProvider = StateProvider<bool>(
  (ref) => false,
);

class CreateCollectionScreen extends ConsumerWidget {
  const CreateCollectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(chosenCategoryProvider);
    final _isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CollectionNameTextField(),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    width: 3,
                    color: primaryColor,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(category?.name ?? ''),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: CustomButton(
                          text: 'Choose category',
                          width: 150,
                          height: 35,
                          fontSize: 15,
                          func: () {
                            Navigator.pushNamed(context, Routes.chooseCategory);
                          },
                          borderRadius: 30),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              ElevatedButton.icon(
                onPressed: _isLoading
                    ? null
                    : () async {
                        ref.read(isLoadingProvider.notifier).state = true;
                        await ref
                            .read(collectionRepositoryProvider)
                            .createCollection(
                              ref.watch(collectionNameTextFieldProvider),
                              category?.id,
                            );
                        ref.read(isLoadingProvider.notifier).state = false;
                        Navigator.pop(context);
                      },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                ),
                icon: _isLoading
                    ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Icon(Icons.create),
                label: const Text(
                  'Create',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
