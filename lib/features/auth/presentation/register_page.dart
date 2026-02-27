import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lafyuu/custom_widget/button.dart';
import 'package:lafyuu/features/auth/presentation/providers/auth_provider.dart';
import '../../../constants.dart';
import '../../../custom_widget/MyTextField.dart';
import '../../../vertical_space.dart';

class RegisterPage extends ConsumerStatefulWidget {
  final VoidCallback onSwitch;

  const RegisterPage({super.key, required this.onSwitch});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),

            const SizedBox(
              height: 72,
              child: Image(image: AssetImage('images/Icon.png')),
            ),

            const VerticalSpace(),

            const Text(
              "Let's Get Started",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const VerticalSpace(),

            const Text(
              "Create a new Account",
              textAlign: TextAlign.center,
            ),

            const VerticalSpace(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                hintText: 'First Name',
                controller: _firstNameController,
              ),
            ),

            const VerticalSpace(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                hintText: 'Email',
                controller: _emailController,
              ),
            ),

            const VerticalSpace(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                hintText: 'Password',
                controller: _passwordController,
                obscureText: true,
              ),
            ),

            const VerticalSpace(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                hintText: 'Confirm Password',
                controller: _confirmPasswordController,
                obscureText: true,
              ),
            ),

            // 🔴 ERROR MESSAGE
            if (authState.error != null)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  authState.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            const VerticalSpace(),

            Container(
              height: 60,
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: MyButton(
                backgroundColor: kprimaryBlue,
                onpressed: authState.isLoading
                    ? null
                    : () async {
                  if (_passwordController.text.trim() !=
                      _confirmPasswordController.text.trim()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Passwords do not match"),
                      ),
                    );
                    return;
                  }

                  await ref.read(authProvider.notifier).register(
                    _firstNameController.text.trim(),
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                },
                child: authState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Register',
                  style:
                  TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔁 SWITCH BACK TO LOGIN
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an Account? "),
                TextButton(
                  onPressed: widget.onSwitch,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: kprimaryBlue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}