import 'package:cariin_buku/core/providers/supabase_provider.dart';
import 'package:cariin_buku/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecase/login_google_usecase.dart';
import '../../domain/usecase/user_sign_out_usecase.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDatasource authRemoteDatasource(Ref ref) {
  final supabaseClient = ref.watch<SupabaseClient>(supabaseClientProvider);
  return AuthRemoteDatasource(supabaseClient: supabaseClient);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final authRemoteDatasource = ref.watch<AuthRemoteDatasource>(
    authRemoteDatasourceProvider,
  );
  return AuthRepositoryImpl(authRemoteDatasource: authRemoteDatasource);
}

@riverpod
LoginGoogleUsecase loginGoogleUsecase(Ref ref) {
  final AuthRepository authRepositoryImpl = ref.watch<AuthRepository>(
    authRepositoryProvider,
  );
  return LoginGoogleUsecase(authRepositoryImpl);
}

@Riverpod(keepAlive: true)
User userAuthtenticate(Ref ref) {
  final supabaseClient = ref.watch<SupabaseClient>(supabaseClientProvider);
  final user = supabaseClient.auth.currentUser;
  return user!;
}

@riverpod
UserSignOutUsecase userSignOutUsecase(Ref ref) {
  final authRepository = ref.watch<AuthRepository>(authRepositoryProvider);
  return UserSignOutUsecase(authRepository);
}
