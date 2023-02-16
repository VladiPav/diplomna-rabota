// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      collectionElements: (json['collectionElements'] as List<dynamic>)
          .map((e) => CollectionElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'categoryId': instance.categoryId,
      'collectionElements': instance.collectionElements,
    };
