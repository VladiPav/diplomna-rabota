import '../../models/collection_model.dart';
import '../api/api_service.dart';

class CollectionRepository {
  final ApiService api;
  CollectionRepository({required this.api,});

  Future<Collection> getCollectionById(id) => api.getCollectionById(id);
}