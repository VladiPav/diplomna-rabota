
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../models/user_model.dart';
import '../api/api_service.dart';

class UserRepo {
  final ApiService _api;

  UserRepo({
      required ApiService api,
  }) : _api = api;

  Future<void> createUser() async {

  }

  Future<List<User>> getFollowers() async {
    final response = await _api.getFollowers();
    print('RESPONSE: $response');
    return response;
  }

}
