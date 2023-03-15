import 'package:json_annotation/json_annotation.dart';

import 'element_model.dart';

part 'collection_element_model.g.dart';

@JsonSerializable()
class CollectionElement {
  final String elementId;
  final String collectionId;
  final Element element;
  final String position;
  CollectionElement(
    this.element,
    this.position,
    this.elementId,
    this.collectionId,
  );

  factory CollectionElement.fromJson(Map<String, dynamic> json) =>
      _$CollectionElementFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionElementToJson(this);
}
