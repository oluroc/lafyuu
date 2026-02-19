import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lafyuu/constants.dart';
import 'package:lafyuu/features/profile/presentation/profile_page.dart';
import 'package:lafyuu/vertical_space.dart';
import '../../../custom_widget/button_container.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(thickness: 3),
          const VerticalSpace(),
          const VerticalSpace(),

          // PROFILE BUTTON
          ButtonContainer(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const Row(
              children: [
                Icon(Icons.person, size: 35, color: kprimaryBlue),
                SizedBox(width: 12),
                Text('Profile'),
              ],
            ),
          ),

          const VerticalSpace(),

          ButtonContainer(
            onTap: () {
              if (kDebugMode) {
                print('Order clicked');
              }
            },
            child: const Row(
              children: [
                Icon(Icons.shopping_bag, size: 35, color: kprimaryBlue),
                SizedBox(width: 12),
                Text('Order'),
              ],
            ),
          ),

          ButtonContainer(
            onTap: () {
              if (kDebugMode) {
                print('Address clicked');
              }
            },
            child: const Row(
              children: [
                Icon(Icons.location_on_outlined, size: 35, color: kprimaryBlue),
                SizedBox(width: 12),
                Text('Address'),
              ],
            ),
          ),

          const VerticalSpace(),

          ButtonContainer(
            onTap: () {
              if (kDebugMode) {
                print('Payment clicked');
              }
            },
            child: const Row(
              children: [
                Icon(Icons.payment, size: 35, color: kprimaryBlue),
                SizedBox(width: 12),
                Text('Payment'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
