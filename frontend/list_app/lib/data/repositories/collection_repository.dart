import '../../models/collection_model.dart';
import '../../models/element_model.dart';
import '../api/api_service.dart';

class CollectionRepository {
  final ApiService api;
  CollectionRepository({
    required this.api,
  });

  Future<Collection> getCollectionById(String id) => api.getCollectionById(id);

  Future<void> createCollection(name, categoryId) =>
      api.createCollection(name, categoryId);

  Future<void> deleteCollection(String id) => api.deleteCollection(id);

  Future<void> addElement(
          String elementId, String collectionId, String position) =>
      api.addElementToCollection(elementId, collectionId, position);

  Future<void> removeElement(String elementId, String collectionId) =>
      api.removeElementFromCollection(elementId, collectionId);
}
