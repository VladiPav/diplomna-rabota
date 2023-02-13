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

  Future<String> testApi() async {
    final result = (await _dio.get('/test')).data;
    print(result);
    return result;
  }

  Future<void> createUser(
    String email,
    String username,
    String firebaseId,
  ) async {
    try {
      final followers = await _dio.post(
        '/users',
        data: {'email': email, 'username': username, 'firebaseId': firebaseId},
      );
      return;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<List<User>> getFollowers() async {
    try {
      final followers = await _dio.get(
        '/users/followers',
      );

      print(followers);

      return (followers.data as List).map((x) => User.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<List<User>> getFollowing() async {
    try {
      final following = await _dio.get(
        '/users/following',
      );

      print(following);

      return (following.data as List).map((x) => User.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<List<User>> searchUser(String query) async {
    try {
      final result = await _dio.get(
        '/users',
        queryParameters: {
          'username': query,
        },
      );
      return (result.data as List).map((x) => User.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final result = await _dio.get(
        '/users/me',
      );
      return User.fromJson(result as Map<String, dynamic>);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  // Future<User> getUserById(String id) async {
  //   try {
  //     final result = await _dio.get(
  //       '/users',
  //     );
  //     return (result.data as List).map((x) => User.fromJson(x)).toList();
  //   } catch (error, stacktrace) {
  //     throw Exception("Exception occured: $error stacktrace: $stacktrace");
  //   }
  // }
}