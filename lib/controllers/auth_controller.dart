import 'package:flutter/material.dart';
import '../models/user_model.dart';

// Controller = the brain of the app
// Holds all data and logic
// Screens just call methods here — they don't do logic themselves

class AuthController extends ChangeNotifier {

  // In-memory list of registered users
  // In a real app this would be a database
  final List<UserModel> _users = [];

  // Currently logged in user
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Register new user
  // Returns true if successful, false if email already exists
  bool register(UserModel user) {
    bool emailExists = _users.any((u) => u.email == user.email);
    if (emailExists) return false;
    _users.add(user);
    return true;
  }

  // Login — finds user by email + password
  bool login(String email, String password) {
    try {
      _currentUser = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      notifyListeners(); // tells UI to rebuild with new data
      return true;
    } catch (e) {
      return false; // no matching user found
    }
  }

  // Logout — clears current user
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}