import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lafyuu/features/auth/presentation/providers/auth_provider.dart';
import 'package:lafyuu/features/auth/presentation/register_page.dart';

import '../../../constants.dart';
import '../../../custom_widget/button.dart';
import '../../../custom_widget/text_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  static String id = 'loginPage';
  final VoidCallback onSwitch;

  const LoginPage({super.key, required this.onSwitch});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 72,
            child: Image(image: AssetImage('images/Icon.png')),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Text(
              textAlign: TextAlign.center,
              'Welcome to Lafyuu',
              style: TextStyle(
                fontSize: 30,
                color: kDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Text(
              textAlign: TextAlign.center,
              'Sign in to continue',
              style: TextStyle(fontSize: 12, color: kDark),
            ),
          ),
          const SizedBox(height: 20),

          // EMAIL FIELD
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined, color: kGrey),
                hintText: 'Email',
                hintStyle: TextStyle(color: kGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: kprimaryBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: kprimaryBlue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: kfaintgrey),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // PASSWORD FIELD
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: kGrey,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                suffixIconColor: kDark,
                hintText: 'Password',
                hintStyle: const TextStyle(color: kGrey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: kprimaryBlue),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: kfaintgrey),
                ),
              ),
            ),
          ),

          // ERROR MESSAGE
          if (authState.error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Text(
                authState.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),

          const SizedBox(height: 30),

          // LOGIN BUTTON
          Container(
            height: 60,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: MyButton(
              backgroundColor: kprimaryBlue,
              onpressed: authState.isLoading
                  ? null
                  : () async {
                await ref.read(authProvider.notifier).login(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );

              },
              child: authState.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                'Sign in',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // CREATE ACCOUNT
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an Account?"),
              MyTextButton(
                onPressed: widget.onSwitch,
                text: 'Create Account',
                color: kprimaryBlue,
                fontize: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}