import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persist_wallet_app/screens/home_screen.dart';
import 'package:persist_wallet_app/widgets/custom_button.dart';

/// A screen widget that displays the completion of a transaction.
class TransactionCompleteScreen extends StatelessWidget {
  final String transactionId;
  final String message;

  /// Constructs a [TransactionCompleteScreen] with the given [transactionId] and [message].
  const TransactionCompleteScreen({
    Key? key,
    required this.transactionId,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HapticFeedback.vibrate();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Complete'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Transaction Complete',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Transaction ID: $transactionId',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              ontap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              hintText: 'Back to Home',
            )
          ],
        ),
      ),
    );
  }
}
