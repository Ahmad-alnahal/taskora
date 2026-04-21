import 'package:taskora/core/config/constants/app_strings.dart';

class AppValidators {
  AppValidators._();

  // Email
  static String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) return AuthStrings.emailRequired;

    // Must contain exactly one @, non-whitespace before and after,
    // and at least one dot after the @.
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) return AuthStrings.emailInvalidFormat;

    return null;
  }

  //  Password
  static String? validatePassword(String? value) {
    final pass = value ?? '';

    if (pass.isEmpty) return AuthStrings.passwordRequired;
    if (pass.length < 8) return AuthStrings.passwordTooShort;
    if (!RegExp(r'[A-Z]').hasMatch(pass)) return AuthStrings.passwordNeedsUppercase;
    if (!RegExp(r'[a-z]').hasMatch(pass)) return AuthStrings.passwordNeedsLowercase;
    if (!RegExp(r'[0-9]').hasMatch(pass)) return AuthStrings.passwordNeedsDigit;

    return null;
  }

  //  Confirm password
  static String? validateConfirmPassword(String? value, String password) {
    final confirm = value ?? '';

    if (confirm.isEmpty) return SignupStrings.confirmPasswordRequired;
    if (confirm != password) return SignupStrings.passwordNotMatch;

    return null;
  }

  // Name
  static String? validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) return SignupStrings.nameRequired;
    if (name.length < 3) return SignupStrings.nameTooShort;

    return null;
  }

  // Hourly rate
  static String? validateHourlyRate(String? value) {
    final raw = value?.trim() ?? '';

    if (raw.isEmpty) return SignupStrings.hourRateRequired;

    final n = double.tryParse(raw);
    if (n == null || n <= 0) return SignupStrings.hourRateMustBePositive;

    return null;
  }
}
