import 'package:flutter/material.dart';
import 'package:persist_wallet_app/provider/user_provider.dart';
import 'package:persist_wallet_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

/// A screen that displays the user's profile information.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(userProvider.user!.username),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_link_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 10),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: Image.network(
                      userProvider.user!.profilePictureUrl,
                    ).image,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${userProvider.user!.firstName} ${userProvider.user!.lastName}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                          Text('Following'),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                          Text('Followers'),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                          Text('Posts'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(ontap: () {}, hintText: 'Edit Profile'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
