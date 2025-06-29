import 'package:cariin_buku/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:cariin_buku/features/authentication/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepositoryImpl({required AuthRemoteDatasource authRemoteDatasource})
    : _authRemoteDatasource = authRemoteDatasource;
  @override
  Future<AuthResponse> googleSignIn() async {
    return await _authRemoteDatasource.googleSignIn();
  }

  @override
  Future<void> signOut() async {
    return await _authRemoteDatasource.signOut();
  }
}
