import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_providers.dart';

part 'auth_notifier.g.dart';

@riverpod
class LoginGoogleNotifier extends _$LoginGoogleNotifier {
  @override
  AsyncValue<User?> build() {
    return AsyncData(null);
  }

  Future<void> loginGoogle() async {
    state = const AsyncLoading();
    try {
      final useCase = ref.read(loginGoogleUsecaseProvider);
      final AuthResponse authResponse = await useCase();
      state = AsyncData(authResponse.user);
      ref.invalidate(userAuthtenticateProvider);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    } finally {
      state = const AsyncData(null);
    }
  }
}

@riverpod
class SignOutNotifier extends _$SignOutNotifier {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      final useCase = ref.read(userSignOutUsecaseProvider);
      await useCase();
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    } finally {
      state = const AsyncData(null);
    }
  }
}
