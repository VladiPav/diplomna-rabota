import '../../models/collection_model.dart';
import '../../models/element_model.dart';
import '../api/api_service.dart';

class CollectionRepository {
  final ApiService api;
  CollectionRepository({
    required this.api,
  });

  Future<Collection> getCollectionById(id) => api.getCollectionById(id);

  Future<void> createCollection(name, categoryId) =>
      api.createCollection(name, categoryId);

  Future<void> addElement(
          String elementId, String collectionId, String position) =>
      api.addElementToCollection(elementId, collectionId, position);
}
