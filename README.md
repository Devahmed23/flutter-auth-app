# flutter-auth-app
Flutter multi-screen app with auth and navigation

# Flutter Multi-Screen App

A complete multi-screen Flutter application built as part of the 
Mobile App Development course (CS-461).

## Features

### Registration Screen
- Full name, email, gender selection
- Password with security requirements:
  - Minimum 6 characters
  - At least 1 uppercase letter
  - At least 1 special character
- Confirm password matching
- All fields required with real-time validation

### Login Screen
- Email format validation
- Password show/hide toggle
- Remember Me checkbox
- Navigation to Dashboard on success

### Dashboard Screen
- User name display with avatar
- Current subjects list:
  - Mobile App Development (CS-461)
  - Software Re-engineering (CS-445)
  - Management Information Systems (MIS-301)
- Tap to navigate to subject detail
- Logout button

### Detail Screen
- Subject header and banner
- Course description
- Class schedule information

## Architecture
- Custom Validator Class
- Controller Layer (business logic separated from UI)
- Enum Implementation (Gender, FormStatus)
- Model Layer (UserModel)

## Project Structure
lib/
├── main.dart
├── enums/
│   └── app_enums.dart
├── models/
│   └── user_model.dart
├── validators/
│   └── app_validators.dart
├── controllers/
│   └── auth_controller.dart
└── screens/
├── login_screen.dart
├── register_screen.dart
├── dashboard_screen.dart
└── detail_screen.dart

## How to Run
```bash
flutter pub get
flutter run
```

## Student Info
- **Name:** Syed Ahmed Khalid
- **Course:** Mobile Application Development (CS-461)
- **Submitted to:** Roshana Mughal