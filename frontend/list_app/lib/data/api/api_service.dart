import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/category_model.dart';
import '../../models/collection_model.dart';
import '../../models/element_model.dart';
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
      return (followers.data as List).map((x) {
        if (x['follower']['profileImagePath'] != null) {
          x['follower']['profileImagePath'] =
              '${dotenv.env['BASE_URL']!}/${x['follower']['profileImagePath']}';
        }
        return User.fromJson(x['follower']);
      }).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<List<User>> getFollowing() async {
    try {
      final following = await _dio.get(
        '/users/following',
      );
      return (following.data as List).map((x) {
        if (x['followed']['profileImagePath'] != null) {
          x['followed']['profileImagePath'] =
              '${dotenv.env['BASE_URL']!}/${x['followed']['profileImagePath']}';
        }
        return User.fromJson(x['followed']);
      }).toList();
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
      return (result.data as List).map((x) {
        if (x['profileImagePath'] != null) {
          x['profileImagePath'] =
              '${dotenv.env['BASE_URL']!}/${x['profileImagePath']}';
        }
        return User.fromJson(x);
      }).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<User> getCurrentUser() async {
    try {
      var result = await _dio.get(
        '/users/me',
      );
      if (result.data['profileImagePath'] != null) {
        result.data['profileImagePath'] =
            '${dotenv.env['BASE_URL']!}/' + result.data['profileImagePath'];
      }
      return User.fromJson(result.data as Map<String, dynamic>);
    } catch (error, stacktrace) {
      throw Exception("BIG SAD");
    }
  }

  Future<User> getUserById(String id) async {
    try {
      final result = await _dio.get(
        '/users',
      );
      return User.fromJson(result as Map<String, dynamic>);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> uploadImage(File file) async {
    final String fileName = file.path.split('/').last;
    final FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await _dio.post('/users/me/profile-image', data: formData);
  }

  Future<bool> isFollowing(String id) async {
    try {
      final result = await _dio.get(
        '/users/$id/following',
      );
      return result.data as bool;
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
      final result = await _dio.delete(
        '/users/$id/unfollow',
      );
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<Collection> getCollectionById(String id) async {
    try {
      final result = await _dio.get(
        '/collections/$id',
      );

      return Collection.fromJson(result.data);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<List<Category>> searchCategory(String name) async {
    try {
      final result = await _dio.get(
        '/categories',
        queryParameters: {
          'name': name,
        },
      );

      return (result.data as List).map((x) => Category.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> createCollection(
    String name,
    String categoryId,
  ) async {
    try {
      final collection = await _dio.post(
        '/collections',
        data: {'name': name, 'categoryId': categoryId},
      );
      return;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> deleteCollection(String collectionId) async {
    try {
      final result = await _dio.delete('/collections/$collectionId');
      return;
    }catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> createCategory(String name) async {
    try {
      final category = await _dio.post(
        '/categories',
        data: {'name': name},
      );
      return;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> createElement(String name, String categoryId) async {
    try {
      final category = await _dio.post(
        '/elements',
        data: {
          'name': name,
          'categoryId': categoryId
        },
      );
      return;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<List<Element>> searchElement(String name, String categoryId, String collectionId) async {
    try {
      final result = await _dio.get(
        '/elements',
        queryParameters: {
          'name': name,
          'categoryId': categoryId,
          'collectionId': collectionId,
        },
      );

      return (result.data as List).map((x) => Element.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> addElementToCollection(
      String elementId, String collectionId, String position) async {
    try {
      final result = await _dio.post(
        '/collections/$collectionId/elements',
        data: {
          'elementId': elementId,
          'position': position
        },
      );

      return;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }

  Future<void> removeElementFromCollection(
      String elementId, String collectionId,
      ) async {
    try {
      final result = await _dio.delete('/collections/$collectionId/elements/$elementId');
      return;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stacktrace: $stacktrace");
    }
  }
}
