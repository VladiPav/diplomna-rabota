import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/api/api_service.dart';

final apiTestStringProvider = FutureProvider<String>(
      (ref) async => ref.read(apiProvider).testApi(),
);

