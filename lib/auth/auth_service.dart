import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  final String redirectToUrl = 'https://frame-app-2025.web.app';

  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabaseClient.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabaseClient.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  String? getCurrentUserEmail() {
    final session = _supabaseClient.auth.currentSession;
    final user = session?.user;

    return user?.email;
  }

  String? getCurrentUserAccessToken() {
    final session = _supabaseClient.auth.currentSession;
    final user = session?.accessToken;
    return user;
  }

  Future<void> signInWithGoogle() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: redirectToUrl,
    );
  }

  Future<void> signInWithDiscord() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.discord,
      redirectTo: redirectToUrl,
    );
  }

  Future<void> signInWithNotion() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.notion,
      redirectTo: redirectToUrl,
    );
  }

  Future<void> signInWithGitHub() async {
    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.github,
      redirectTo: redirectToUrl,
    );
  }
}
