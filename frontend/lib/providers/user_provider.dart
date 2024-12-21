import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // Sets the user data and notifies listeners.
  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // Clears the user data and notifies listeners.
  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
