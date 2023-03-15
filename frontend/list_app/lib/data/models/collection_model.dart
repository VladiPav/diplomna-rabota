import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';
import 'collection_element_model.dart';

part 'collection_model.g.dart';

@JsonSerializable()
class Collection {
  Collection({
    required this.id,
    required this.userId,
    required this.name,
    required this.categoryId,
    required this.collectionElements,
    this.category,
  });

  final String id;
  final String name;
  final String userId;
  final String categoryId;
  final Category? category;
  final List<CollectionElement> collectionElements;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
