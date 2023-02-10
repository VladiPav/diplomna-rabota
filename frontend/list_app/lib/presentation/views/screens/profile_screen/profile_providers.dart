import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_providers/apiServiceProvider.dart';

final apiTestStringProvider = FutureProvider<String>(
      (ref) async => ref.read(apiProvider).testApi(),
);

