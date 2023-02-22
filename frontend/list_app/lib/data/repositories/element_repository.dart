import '../../models/element_model.dart';
import '../api/api_service.dart';

class ElementRepository {
  final ApiService api;
  ElementRepository({
    required this.api,
  });

  // Future<Element> getElementById(id) => api.getElementById(id);

  Future<void> createElement(String name, String categoryId) =>
      api.createElement(name, categoryId);

  Future<List<Element>> searchElement(
          String name, String categoryId, String collectionId) =>
      api.searchElement(name, categoryId, collectionId);
}
