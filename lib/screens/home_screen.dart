import 'package:flutter/material.dart';
import 'package:persist_wallet_app/screens/create_wallet_screen.dart';

import '../widgets/custom_button.dart';

/// A screen that displays the home screen of the wallet app.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://wallpapersmug.com/u/7a20ca/crypto-coins-abstract.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Welcome to your Wallet. Your Wallet is a gateway to the decentralized web. You can use it to store, send, and Receive cryptocurrencies.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  hintText: 'Create Wallet',
                  ontap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CreateWalletScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
