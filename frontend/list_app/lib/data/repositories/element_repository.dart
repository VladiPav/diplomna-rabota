import '../../models/element_model.dart';
import '../api/api_service.dart';

class ElementRepository {
  final ApiService api;
  ElementRepository({
    required this.api,
  });

  // Future<Element> getElementById(id) => api.getElementById(id);

  Future<void> createElement(name, categoryId) =>
      api.createElement(name, categoryId);

  Future<List<Element>> searchElement(name, categoryId) => api.searchElement(name, categoryId);
}
