import 'package:flutter/material.dart';
import 'package:persist_wallet_app/provider/user_provider.dart';
import 'package:persist_wallet_app/provider/wallet_provider.dart';
import 'package:persist_wallet_app/screens/send_screen.dart';
import 'package:persist_wallet_app/widgets/custom_button_2.dart';
import 'package:provider/provider.dart';

/// The screen that displays the user's wallet information.
class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Consumer<WalletProvider>(
        builder: (context, walletProvider, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: const Text('Wallet'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  // Container displaying the total balance and wallet address
                  Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Total Balance',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            "\$${userProvider.user!.balance.toString()}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            userProvider.user!.walletAddress,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row containing "Send" and "Swap" buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomBotton2(
                          ontap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SendScreen(),
                              ),
                            );
                          },
                          hintText: 'Send',
                          isColorRed: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomBotton2(
                          ontap: () {},
                          hintText: 'Swap',
                          isColorRed: false,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Tab bar for switching between "Tokens" and "Activity" tabs
                          TabBar(
                            tabs: [
                              Tab(text: 'Tokens'),
                              Tab(text: 'Activity'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Center(
                                  child: Text('Tokens content goes here'),
                                ),
                                Center(
                                  child: Text('Activity content goes here'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
