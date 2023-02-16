// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_element_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionElement _$CollectionElementFromJson(Map<String, dynamic> json) =>
    CollectionElement(
      Element.fromJson(json['element'] as Map<String, dynamic>),
      json['position'] as String,
      json['elementId'] as String,
      json['collectionId'] as String,
    );

Map<String, dynamic> _$CollectionElementToJson(CollectionElement instance) =>
    <String, dynamic>{
      'elementId': instance.elementId,
      'collectionId': instance.collectionId,
      'element': instance.element,
      'position': instance.position,
    };
