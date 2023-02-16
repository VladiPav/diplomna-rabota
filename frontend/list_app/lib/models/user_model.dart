import 'package:json_annotation/json_annotation.dart';

import '../data/api/api_service.dart';
import 'collection_model.dart';

part 'user_model.g.dart';


@JsonSerializable()
class User {
  User({
    required this.id,
    required this.firebaseId,
    required this.username,
    required this.email,
    required this.collections,
    this.profileImagePath,
  });

  final String id;
  final String firebaseId;
  final String username;
  final String email;
  final String? profileImagePath;
  final List<Collection> collections;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}
