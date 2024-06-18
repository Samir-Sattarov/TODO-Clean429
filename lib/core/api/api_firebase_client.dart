import 'dart:developer';

import 'package:clean_arch_example/core/api/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../features/auth/data/model/user_model.dart';
import '../../main.dart';

class ApiFirebaseClient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ================ Auth ================ //

  signIn(String email, String password) async {
    try {
      final UserCredential response = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = response.user;

      final box = await Hive.openBox("auth");

      await box.put("userId", user!.uid);

      final userJson = await getDataById(
        FirebaseCollections.users,
        id: user!.uid,
      );

      final model = UserModel.fromJson(userJson);

      print(userJson);
      return model;
    } catch (error) {
      throw Exception(error);
    }
  }

  getCurrentUser() async {
    try {
      final box = await Hive.openBox("auth");

      final userId = await box.get("userId");

      if (userId == null) {
        throw Exception("User id in box not found!");
      }

      final userJson = await getDataById(
        FirebaseCollections.users,
        id: userId,
      );

      print(userJson);

      final model = UserModel.fromJson(userJson);

      return model;
    } catch (error) {
      throw Exception(error);
    }
  }

  signUp(String email, String password) async {
    print("Register $email");

    try {
      final UserCredential response =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      final model = UserModel.empty(id: user!.uid, email: email);

      final box = await Hive.openBox("auth");

      await box.put("userId", model.id);
      await addToCollection(
        FirebaseCollections.users,
        json: model.toJson(),
        id: model.id,
      );
    } catch (error) {
      throw Exception(error);
    }
  }

  // ================ Firestore ================ //

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

  Future<dynamic> getDataById(String collection, {required String id}) async {
    final response = await _firestore.collection(collection).doc(id).get();

    return response.data();
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
