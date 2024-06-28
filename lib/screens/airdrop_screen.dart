import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../services/wallet_services.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

/// This file contains the implementation of the AirdropScreen widget.
/// The AirdropScreen widget is responsible for displaying the screen where users can request an airdrop.
/// It includes a form with an address input field, a numeric keypad for entering the amount, and a button to request the airdrop.
/// The widget uses the UserProvider to access user information and the WalletServices to make the airdrop request.
///
/// The AirdropScreen widget is a stateful widget, as it needs to maintain the state of the expression entered by the user.
/// The expression is displayed in a text widget and is updated when the user presses the numeric keypad buttons.
/// The widget also includes form validation to ensure that the address input field is not empty and the amount is a valid number.
///
/// The AirdropScreen widget is built using the Scaffold widget and includes an AppBar with the title "Request Airdrop".
/// Inside the body of the Scaffold, the widget uses the Consumer widget to listen to changes in the UserProvider.
/// The Consumer widget rebuilds the widget whenever the userProvider changes, ensuring that the user information is up to date.
///
/// The AirdropScreen widget also includes a dispose method to dispose of the addressController when the widget is removed from the widget tree.
///
/// The widget includes helper methods like _onPressed, which is called when a keypad button is pressed, and _buildButton, which builds a button widget for the numeric keypad.
///
/// To request an airdrop, the user needs to enter an address and an amount, and then press the "Request Airdrop" button.
/// The button's onTap callback triggers the requestAirdrop method from the WalletServices, passing the userProvider, walletAddress, and amount as parameters.
/// If the request is successful, a snackbar is displayed with the status message returned from the server.
class AirdropScreen extends StatefulWidget {
  const AirdropScreen({Key? key}) : super(key: key);

  @override
  State<AirdropScreen> createState() => _AirdropScreenState();
}

class _AirdropScreenState extends State<AirdropScreen> {
  TextEditingController addressController = TextEditingController();
  String _expression = '';

  // Handles the button press event for the numeric keypad
  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
      } else if (buttonText == '<-') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  // Builds a button widget for the numeric keypad
  Widget _buildButton(String text) {
    return Expanded(
      child: TextButton(
        onPressed: () => _onPressed(text),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  final _airdropFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Airdrop'),
      ),
      body: Consumer<UserProvider>(builder: (context, userProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _airdropFormKey,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  controller: addressController,
                  hintText: 'Enter address',
                  textInputAction: TextInputAction.done,
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        _expression,
                        style: const TextStyle(
                          fontSize: 48.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.ethereum),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'ETH',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'AMOUNT',
                          style: TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      GridView.count(
                        crossAxisSpacing: 61,
                        crossAxisCount:
                            3, // Adjust the number of buttons per row
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildButton('7'),
                          _buildButton('8'),
                          _buildButton('9'),
                          _buildButton('4'),
                          _buildButton('5'),
                          _buildButton('6'),
                          _buildButton('1'),
                          _buildButton('2'),
                          _buildButton('3'),
                          _buildButton('.'),
                          _buildButton('0'),
                          IconButton(
                            onPressed: () => _onPressed('<-'),
                            icon: const Icon(Icons.backspace_outlined),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CustomButton(
                  hintText: 'Request Airdrop',
                  ontap: () async {
                    HapticFeedback.vibrate();

                    if (_airdropFormKey.currentState!.validate()) {
                      var jsonResponse = await WalletServices.requestAirdrop(
                        context,
                        userProvider: userProvider,
                        walletAddress: addressController.text.trim(),
                        amount: double.parse(_expression),
                      );

                      if (jsonResponse != null) {
                        showSnackBar(context, jsonResponse['status']);
                      }
                    }
                  },
                ),
                const Spacer()
              ],
            ),
          ),
        );
      }),
    );
  }
}
