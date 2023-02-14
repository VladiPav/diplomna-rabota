import 'dart:io';

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
      var result = await _dio.get(
        '/users/me',
      );

      result.data['profileImagePath'] = dotenv.env['BASE_URL']! + '/' + result.data['profileImagePath'];
      print('RESULT:\n\n${result}');
      return User.fromJson(result.data as Map<String, dynamic>);
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

  Future<void> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image":
      await MultipartFile.fromFile(file.path, filename:fileName),
    });
    print('FILE:\n\n${fileName}');
    final response = await _dio.post("/users/me/profile-image", data: formData);
  }

  Future<bool> isFollowing(String id) async {
    try {
      var result = await _dio.get(
        '/users/$id/following',
      );
      print(result);
      return false;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> follow(String id) async {
    try {
      var result = await _dio.post(
        '/users/$id/follow',
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> unfollow(String id) async {
    try {
      var result = await _dio.delete(
        '/users/$id/unfollow',
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }
}