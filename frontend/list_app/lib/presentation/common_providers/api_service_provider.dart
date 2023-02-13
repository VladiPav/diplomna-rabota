import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api/api_service.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());
