import 'package:json_annotation/json_annotation.dart';

import 'element_model.dart';

part 'collection_model.g.dart';

@JsonSerializable()
class Collection {
  Collection({
    required this.id,
    required this.category,
    required this.userId,
    required this.name,
    this.elements,
  });

  final String id;
  final String category;
  final String name;
  final String userId;
  final List<Element>? elements;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
