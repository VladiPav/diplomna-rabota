import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/element_model.dart';
import '../../../common_providers/repository_providers.dart';

final elementsProvider = FutureProvider.family.autoDispose<List<Element>, String>(
  (ref, categoryId) => ref
      .read(elementRepositoryProvider)
      .searchElement(ref.watch(elementTextFieldProvider), categoryId),
);

final elementTextFieldProvider = StateProvider<String>(
  (ref) => '',
);

final newElementTextFieldProvider = StateProvider<String>(
  (ref) => '',
);

final chosenElementProvider = StateProvider<Element?>(
      (ref) => null,
);