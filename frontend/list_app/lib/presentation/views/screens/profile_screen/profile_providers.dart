import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_providers/api_service_provider.dart';

final apiTestStringProvider = FutureProvider<String>(
      (ref) async => ref.read(apiProvider).testApi(),
);
