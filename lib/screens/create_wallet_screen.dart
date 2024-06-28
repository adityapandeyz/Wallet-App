import 'package:flutter/material.dart';
import 'package:persist_wallet_app/provider/user_provider.dart';
import 'package:persist_wallet_app/utils/utils.dart';
import 'package:persist_wallet_app/widgets/custom_button.dart';
import 'package:persist_wallet_app/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../services/wallet_services.dart';

/// A screen that allows the user to create a wallet.
class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  TextEditingController walletNameController = TextEditingController();
  TextEditingController walletPincodeController = TextEditingController();

  final _createWalletFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    walletNameController.dispose();
    walletPincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Wallet'),
        ),
        body: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
              child: Form(
                key: _createWalletFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: walletNameController,
                      isTitleRequired: true,
                      titleText: 'Wallet Name',
                      hintText: "Eg. Jack's Wallet",
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: walletPincodeController,
                      isTitleRequired: true,
                      titleText: 'Pincode',
                      hintText: "Eg. 6-digit numeric pin",
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      hintText: 'Create',
                      ontap: () {
                        if (int.tryParse(walletPincodeController.text) ==
                            null) {
                          showSnackBar(
                              context, 'Pincode must be of type number.');
                          return;
                        }

                        if (_createWalletFormKey.currentState!.validate()) {
                          WalletServices.createWallet(
                            context,
                            userProvider: userProvider,
                            walletName: walletNameController.text,
                            pincode: int.parse(
                              walletPincodeController.text.trim(),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
