import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persist_wallet_app/provider/user_provider.dart';
import 'package:persist_wallet_app/screens/navigation_screen.dart';
import 'package:provider/provider.dart';

/// A class that provides login services for the application.
class LoginServices {
  /// A static method to login a user.
  ///
  /// This method sends a POST request to the login API endpoint with the provided
  /// username and password. If the login is successful, it sets the user data in
  /// the [UserProvider] and navigates to the [NavigationScreen].
  ///
  /// If there is an error during the login process, an exception is thrown.
  static Future loginUser(
    BuildContext context, {
    required String username,
    required String password,
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
        Uri.parse('https://api.socialverseapp.com/user/login'),
        body: jsonEncode(
          {"mixed": "Test", "password": "test-pass"},
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Hide loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(response.body);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const NavigationScreen(),
          ),
        );
      } else {
        throw Exception('Error fetching data from the database.');
      }
    } catch (e) {
      throw Exception('Error connecting to server - $e');
    } finally {
      // // Hide loading indicator
      // Navigator.of(context).pop();
    }
  }
}
