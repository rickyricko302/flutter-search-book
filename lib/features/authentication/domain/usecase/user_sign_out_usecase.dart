import '../repositories/auth_repository.dart';

class UserSignOutUsecase {
  final AuthRepository _authRepository;

  UserSignOutUsecase(this._authRepository);

  Future<void> call() async {
    return await _authRepository.signOut();
  }
}
