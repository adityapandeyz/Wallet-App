import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persist_wallet_app/provider/user_provider.dart';
import 'package:persist_wallet_app/screens/wallet_screen.dart';
import 'package:provider/provider.dart';

import '../provider/wallet_provider.dart';

/// A class that provides various wallet services such as creating a wallet,
/// transferring balance, getting balance, and requesting airdrop.
class WalletServices {
  /// Creates a wallet with the given parameters.
  ///
  /// The [context] is the build context of the widget.
  /// The [userProvider] is the provider for user-related data.
  /// The [walletName] is the name of the wallet to be created.
  /// The [pincode] is the pincode for the wallet.
  ///
  /// Throws an exception if there is an error creating the wallet.
  static Future createWallet(
    BuildContext context, {
    required UserProvider userProvider,
    required String walletName,
    required int pincode,
  }) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      final http.Response response = await http.post(
          Uri.parse('https://api.socialverseapp.com/solana/wallet/create'),
          body: jsonEncode(
            {
              "wallet_name": walletName,
              "network": "devnet",
              "user_pin": pincode.toString(),
            },
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Flic-Token': userProvider.user!.token,
          });

      // Hide loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 201) {
        Provider.of<WalletProvider>(context, listen: false)
            .createWallet(response.body);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const WalletScreen(),
          ),
        );
      } else {
        throw Exception('Error fetching data from the database.');
      }
    } catch (e) {
      throw Exception('Error connecting to server - $e');
    }
  }

  /// Transfers balance from one wallet to another.
  ///
  /// The [context] is the build context of the widget.
  /// The [userProvider] is the provider for user-related data.
  /// The [recipientAddress] is the address of the recipient wallet.
  /// The [sendersAddress] is the address of the sender wallet.
  /// The [amount] is the amount to be transferred.
  /// The [pincode] is the pincode for the wallet.
  ///
  /// Returns the response body if the transfer is successful.
  /// Throws an exception if there is an error transferring the balance.
  static Future transferBalance(
    BuildContext context, {
    required UserProvider userProvider,
    required String recipientAddress,
    required String sendersAddress,
    required double amount,
    required int pincode,
  }) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      final http.Response response = await http.post(
          Uri.parse('https://api.socialverseapp.com/solana/wallet/create'),
          body: jsonEncode(
            {
              "recipient_address": recipientAddress,
              "network": "devnet",
              "sender_address": sendersAddress,
              "amount": amount,
              "user_pin": pincode.toString()
            },
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Flic-Token': userProvider.user!.token,
          });

      // Hide loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error fetching data from the database.');
      }
    } catch (e) {
      throw Exception('Error connecting to server - $e');
    }
  }

  /// Gets the balance of a wallet.
  ///
  /// The [context] is the build context of the widget.
  /// The [userProvider] is the provider for user-related data.
  ///
  /// Returns the response body if the balance retrieval is successful.
  /// Throws an exception if there is an error getting the balance.
  static Future getBalance(
    BuildContext context, {
    required UserProvider userProvider,
  }) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      final http.Response response = await http.get(
          Uri.parse(
              'https://api.socialverseapp.com/solana/wallet/balance?network=devnet&wallet_address=${userProvider.user!.walletAddress}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Flic-Token': userProvider.user!.token,
          });

      // Hide loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error fetching data from the database.');
      }
    } catch (e) {
      throw Exception('Error connecting to server - $e');
    }
  }

  /// Requests an airdrop of balance to a wallet.
  ///
  /// The [context] is the build context of the widget.
  /// The [userProvider] is the provider for user-related data.
  /// The [walletAddress] is the address of the wallet to receive the airdrop.
  /// The [amount] is the amount to be airdropped.
  ///
  /// Returns the response body if the airdrop is successful.
  /// Throws an exception if there is an error requesting the airdrop.
  static Future requestAirdrop(
    BuildContext context, {
    required UserProvider userProvider,
    required String walletAddress,
    required double amount,
  }) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      final http.Response response = await http.post(
          Uri.parse('https://api.socialverseapp.com/solana/wallet/airdrop'),
          body: {
            "wallet_address": userProvider.user!.walletAddress,
            "network": "devnet",
            "amount": amount
          },
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Flic-Token': userProvider.user!.token,
          });

      // Hide loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error fetching data from the database.');
      }
    } catch (e) {
      throw Exception('Error connecting to server - $e');
    }
  }
}
