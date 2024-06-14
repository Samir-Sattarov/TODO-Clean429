import 'package:cloud_firestore/cloud_firestore.dart';

import '../../main.dart';

class ApiFirebaseClient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> getAllDocumentsFromCollection(String collection) async {
    final response = await _firestore.collection(collection).get();

    final List<Map<String, dynamic>> listJson = response.docs
        .map(
          (element) => element.data(),
        )
        .toList();

    print(listJson.runtimeType);

    return listJson;
  }

  Future<void> addToCollection(
    String collection, {
    required Map<String, dynamic> json,
    String? id,
  }) async {
    await _firestore.collection(collection).doc(id ?? uuid.v4()).set(json);
  }

  Future<void> delete(
    String collection, {
    required String id,
  }) async {
    await _firestore.collection(collection).doc(id).delete();
  }

  deleteListDataFromCollection(
    String collection, {
    required List<String> listId,
  }) async {
    for (var element in listId) {
      await delete(collection, id: element);
    }
  }
}
