import 'package:clean_arch_example/core/api/api_firebase_client.dart';

abstract class AuthRemoteDataSource {
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource{
  final ApiFirebaseClient client;

  AuthRemoteDataSourceImpl(this.client);


  @override
  Future<void> signIn(String email, String password) async {
    await client.signIn(email, password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await client.signUp(email, password);

  }
}