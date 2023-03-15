// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      firebaseId: json['firebaseId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      collections: (json['collections'] as List<dynamic>)
          .map((e) => Collection.fromJson(e as Map<String, dynamic>))
          .toList(),
      profileImagePath: json['profileImagePath'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firebaseId': instance.firebaseId,
      'username': instance.username,
      'email': instance.email,
      'profileImagePath': instance.profileImagePath,
      'collections': instance.collections,
    };