import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_providers/repository_providers.dart';

final collectionNameTextFieldProvider =
    StateProvider<String>((ref) => '');

final categoriesProvider = FutureProvider(
  (ref) => ref
      .read(categoryRepositoryProvider)
      .searchCategory(ref.read(categoryTextFieldControllerProvider).text),
);

final categoryTextFieldControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
