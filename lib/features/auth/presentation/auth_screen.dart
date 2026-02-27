import 'package:flutter/cupertino.dart';
import 'package:lafyuu/features/auth/presentation/register_page.dart';

import 'login_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginPage(
      onSwitch: () {
        setState(() => isLogin = false);
      },
    )
        : RegisterPage(
      onSwitch: () {
        setState(() => isLogin = true);
      },
    );
  }
}