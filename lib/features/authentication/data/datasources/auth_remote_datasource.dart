import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasource({required this.supabaseClient});

  Future<AuthResponse> googleSignIn() async {
    String clientId = dotenv.get('OAUTH_CLIENT_ID', fallback: '');
    final GoogleSignIn googleSignIn = GoogleSignIn(clientId: clientId);
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    return supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signOut() async {
    String clientId = dotenv.get('OAUTH_CLIENT_ID', fallback: '');
    final GoogleSignIn googleSignIn = GoogleSignIn(clientId: clientId);
    await supabaseClient.auth.signOut(scope: SignOutScope.local);
    await googleSignIn.signOut();
    if (googleSignIn.currentUser != null) {
      await googleSignIn.disconnect();
    }
  }
}
