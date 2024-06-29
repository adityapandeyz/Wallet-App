/// This file contains the implementation of the [PinInputScreen] widget.
/// The [PinInputScreen] is responsible for displaying a screen where the user can enter a pincode.
/// The pincode is used for transferring balance from one user to another.
/// The screen includes a pincode input field and a continue button.
/// When the user taps on the continue button, the pincode is validated and the balance transfer is initiated.
/// If the balance transfer is successful, the user is navigated to the [TransactionCompleteScreen] to view the transaction details.
///
/// The [PinInputScreen] requires the following parameters:
/// - [recipientAddress]: The address of the recipient user.
/// - [sendersAddress]: The address of the sender user.
/// - [amount]: The amount to be transferred.
/// - [userProvider]: An instance of the [UserProvider] class.
///
/// Example usage:
/// ```dart
/// PinInputScreen(
///   recipientAddress: 'recipient_address',
///   sendersAddress: 'sender_address',
///   amount: 100.0,
///   userProvider: userProviderInstance,
/// )
/// ```
import 'package:flutter/material.dart';
import 'package:persist_wallet_app/screens/transaction_complete_screen.dart';

import '../provider/user_provider.dart';
import '../services/wallet_services.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class PinInputScreen extends StatefulWidget {
  final String recipientAddress;
  final String sendersAddress;
  final double amount;
  final UserProvider userProvider;

  /// Constructs a [PinInputScreen] with the given parameters.
  const PinInputScreen({
    Key? key,
    required this.recipientAddress,
    required this.sendersAddress,
    required this.amount,
    required this.userProvider,
  });

  @override
  State<PinInputScreen> createState() => _PinInputScreenState();
}

class _PinInputScreenState extends State<PinInputScreen> {
  TextEditingController pincodeController = TextEditingController();

  final _pinFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Pin'),
      ),
      body: Form(
        key: _pinFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8),
          child: Column(
            children: [
              CustomTextField(
                isTitleRequired: true,
                titleText: 'Pincode',
                obscureText: true,
                controller: pincodeController,
                hintText: 'Eg. 6-digit numeric pin',
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                ontap: () async {
                  if (int.tryParse(pincodeController.text) == null) {
                    showSnackBar(context, 'Pincode must be of type number.');
                    return;
                  }
                  if (_pinFormKey.currentState!.validate()) {
                    var jsonResponse = await WalletServices.transferBalance(
                      context,
                      userProvider: widget.userProvider,
                      recipientAddress: widget.recipientAddress,
                      sendersAddress: widget.sendersAddress,
                      amount: widget.amount,
                      pincode: int.parse(
                        pincodeController.text.trim(),
                      ),
                    );

                    if (jsonResponse['status'] == 'success') {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => TransactionCompleteScreen(
                            transactionId: jsonResponse['transactionId'],
                            message: jsonResponse['message'],
                          ),
                        ),
                        (route) => false,
                      );
                    }
                  }
                },
                hintText: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
