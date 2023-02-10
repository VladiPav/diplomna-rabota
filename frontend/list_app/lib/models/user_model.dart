import 'package:json_annotation/json_annotation.dart';

import 'collection_model.dart';

part 'user_model.g.dart';


@JsonSerializable()
class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    this.profilePictureUrl,
    this.collections,
  });

  final String id;
  final String username;
  final String email;
  final String? profilePictureUrl;
  final List<Collection>? collections;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}
