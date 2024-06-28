import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/wallet.dart';

/// A provider class for managing the wallet state.
class WalletProvider with ChangeNotifier {
  Wallet? _wallet;

  /// Getter for the wallet instance.
  Wallet? get wallet => _wallet;

  /// Creates a wallet using the provided JSON response.
  ///
  /// The [jsonResponse] parameter is a JSON string representing the wallet data.
  /// It is decoded using `jsonDecode` and then converted to a [Wallet] object
  /// using the `Wallet.fromJson` factory method.
  ///
  /// After creating the wallet, this method notifies all the listeners
  /// that the wallet has been updated.
  void createWallet(String jsonResponse) {
    final data = jsonDecode(jsonResponse);
    _wallet = Wallet.fromJson(data);
    notifyListeners();
  }
}
