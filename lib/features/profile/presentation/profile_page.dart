import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/presentation/login_page.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../../../constants.dart';

class ProfileScreen extends ConsumerWidget {
  static String id = 'profilePage';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // PROFILE ICON
            const CircleAvatar(
              radius: 50,
              backgroundColor: kprimaryBlue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 20),

            // USER EMAIL
            Text(
              user?.displayName ?? "User",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              user?.email ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kprimaryBlue),
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();

                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  }
                },

                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
