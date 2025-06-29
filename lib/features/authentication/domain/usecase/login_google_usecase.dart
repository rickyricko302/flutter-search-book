import 'package:cariin_buku/features/authentication/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginGoogleUsecase {
  final AuthRepository authRepository;

  LoginGoogleUsecase(this.authRepository);
  Future<AuthResponse> call() async {
    return await authRepository.googleSignIn();
  }
}
