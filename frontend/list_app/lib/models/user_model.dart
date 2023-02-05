import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';


@JsonSerializable()
class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.profilePictureUrl,
  });

  final String id;
  final String username;
  final String email;
  final String profilePictureUrl;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}
