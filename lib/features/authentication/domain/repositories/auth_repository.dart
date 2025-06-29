import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<AuthResponse> googleSignIn();
  Future<void> signOut();
}
