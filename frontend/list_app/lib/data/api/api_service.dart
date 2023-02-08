import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_model.dart';
import 'auth_interseptor.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
    ),
  )..interceptors.add(
      AuthInterceptor(),
    );

  Future<List<User>> getFollowers() async {
    try {
      final followers = await _dio.get(
        '/users/followers',
      );
      return (followers.data as List).map((x) => User.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<String> testApi() async {
    final result = (await _dio.get('/test')).data;
    print(result);
    return result;
  }
}

final apiProvider = Provider<ApiService>((ref) => ApiService());
