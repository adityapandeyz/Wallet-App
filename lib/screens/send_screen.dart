import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persist_wallet_app/provider/user_provider.dart';
import 'package:persist_wallet_app/widgets/custom_button.dart';
import 'package:persist_wallet_app/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import 'pin_input_screen.dart';

/// A screen for sending cryptocurrency.
class SendScreen extends StatefulWidget {
  const SendScreen({Key? key}) : super(key: key);

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  TextEditingController addressController = TextEditingController();
  String _expression = '';

  /// Handles button press events.
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

  /// Builds a button widget with the given text.
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

  final _sendFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Form(
              key: _sendFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: addressController,
                    hintText: 'Recipient Address',
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
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      // userProvider.user!.balance.toString(),
                      '0 - $_expression',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
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
                    ontap: () {
                      HapticFeedback.vibrate();

                      if (_sendFormKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PinInputScreen(
                              recipientAddress: addressController.text.trim(),
                              sendersAddress: userProvider.user!.walletAddress,
                              amount: double.parse(_expression),
                              userProvider: userProvider,
                            ),
                          ),
                        );
                      }
                    },
                    hintText: 'Send',
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
