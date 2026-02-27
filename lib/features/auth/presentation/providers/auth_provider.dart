import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🔐 AUTH STATE
class AuthState {
  final bool isLoading;
  final String? error;
  final User? user; // 🔥 ADD THIS

  const AuthState({
    this.isLoading = false,
    this.error,
    this.user,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    bool? isLoading,
    String? error,
    User? user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
    );
  }
}

/// 🔐 AUTH NOTIFIER (Modern Riverpod 2.x)
class AuthNotifier extends Notifier<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  AuthState build() {
    return const AuthState();
  }

  // 🔐 LOGIN
  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User after login: ${_auth.currentUser}");

      state = AuthState(
        isLoading: false,
        user: _auth.currentUser,
      );
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

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await user.updateDisplayName(firstName);

        // 🔥 Force refresh user session
        await user.reload();
      }

      state = AuthState(
        isLoading: false,
        user: credential.user,
      );
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

      print("USER AFTER LOGOUT: ${_auth.currentUser}");

      state = const AuthState();
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
NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);