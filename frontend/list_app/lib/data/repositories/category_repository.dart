import '../../models/category_model.dart';
import '../api/api_service.dart';

class CategoryRepository {
  final ApiService api;
  CategoryRepository({required this.api,});

  Future<List<Category>> searchCategory(name) => api.searchCategory(name);
}