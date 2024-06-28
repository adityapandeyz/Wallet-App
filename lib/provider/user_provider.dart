import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user.dart';

/// A provider class for managing user data.
///
/// This class is responsible for storing and updating the user data.
/// It provides a getter method to access the current user data and a
/// method to set the user data based on a JSON response.
class UserProvider with ChangeNotifier {
  UserModel? _user;

  /// Getter method to access the current user data.
  UserModel? get user => _user;

  /// Sets the user data based on a JSON response.
  ///
  /// The [jsonResponse] parameter is a JSON string representing the user data.
  /// It decodes the JSON string and creates a [UserModel] object from the data.
  /// The [notifyListeners] method is called to notify any listeners of the change.
  void setUser(String jsonResponse) {
    final data = jsonDecode(jsonResponse);
    _user = UserModel.fromJson(data);
    notifyListeners();
  }
}
