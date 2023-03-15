import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/category_model.dart';
import '../../../common_providers/repository_providers.dart';

final categoryTextFieldProvider = StateProvider<String>((ref) => '');

final newCategoryTextFieldProvider = StateProvider<String>((ref) => '');

final categoriesProvider = FutureProvider<List<Category>>(
  (ref) => ref.read(categoryRepositoryProvider).searchCategory(
        ref.watch(categoryTextFieldProvider),
      ),
);

final chosenCategoryProvider = StateProvider<Category?>(
    (ref) => null,
);
