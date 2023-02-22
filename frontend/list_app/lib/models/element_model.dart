
import 'package:json_annotation/json_annotation.dart';

part 'element_model.g.dart';

@JsonSerializable()
class Element {
  Element({required this.name, required this.id});
  final String id;
  final String name;

  factory Element.fromJson(Map<String, dynamic> json) => _$ElementFromJson(json);

  Map<String, dynamic> toJson() => _$ElementToJson(this);
}
