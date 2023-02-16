import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/collection_model.dart';
import 'repository_providers.dart';

final collectionIdProvider = StateProvider<String>(
  (ref) => '',
);

final collectionProvider = FutureProvider<Collection>(
  (ref) => ref
      .read(collectionRepositoryProvider)
      .getCollectionById(ref.watch(collectionIdProvider)),
);
