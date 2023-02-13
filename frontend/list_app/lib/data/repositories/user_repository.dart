
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../models/user_model.dart';
import '../api/api_service.dart';

class UserRepository {
  final ApiService api;

  UserRepository({
      required this.api,
  });

  Future<void> createUser() async {
  }

  Future<List<User>> getFollowers() async {
    final response = await api.getFollowers();
    print('RESPONSE: $response');
    return response;
  }

  Future<List<User>> getFollowing() async {
    final response = await api.getFollowing();
    print('RESPONSE: $response');
    return response;
  }

  Future<User> getCurrentUser() => api.getCurrentUser();

  Future<List<User>> searchUser(query) => api.searchUser(query);


// Future<User> getUserById(String id) async {
  //   return User();
  // }

}
