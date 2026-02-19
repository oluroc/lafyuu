import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// 🔐 AUTH STATE
class AuthState {
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 🔐 AUTH NOTIFIER
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔐 LOGIN
  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // success
      state = const AuthState(); // 🔥 fully reset clean state
    } on FirebaseAuthException catch (e) {
      state = AuthState(
        isLoading: false,
        error: e.message ?? "Login failed",
      );
    }
  }

  // 📝 REGISTER
  Future<void> register(
      String firstName,
      String email,
      String password,
      ) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final credential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await user.updateDisplayName(firstName);
      }

      state = const AuthState(); // 🔥 reset clean state
    } on FirebaseAuthException catch (e) {
      state = AuthState(
        isLoading: false,
        error: e.message ?? "Registration failed",
      );
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _auth.signOut();

      state = const AuthState(); // 🔥 VERY IMPORTANT
    } catch (e) {
      state = AuthState(
        isLoading: false,
        error: "Logout failed",
      );
    }
  }
}

/// 🔐 PROVIDER
final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
