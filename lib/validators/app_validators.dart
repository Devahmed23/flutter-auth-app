// This is the Custom Validator Class your teacher requires
// All validation rules live in ONE place
// Screens just call these methods — no logic in UI files

class AppValidators {

  // Checks if a field is empty
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null; // null = no error in Flutter
  }

  // Checks email format
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email (e.g. user@example.com)';
    }
    return null;
  }

  // Checks all 3 password rules from the PDF
  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Must contain at least 1 uppercase letter';
    }
    if (!value.contains(RegExp(r'[!@#\$&*~%^()_+]'))) {
      return 'Must contain at least 1 special character (!@#\$...)';
    }
    return null;
  }

  // Checks if confirm password matches original
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Checks gender was selected
  static String? gender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }
}