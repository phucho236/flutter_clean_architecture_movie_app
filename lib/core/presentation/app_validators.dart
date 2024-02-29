class AppValidators {
  static bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._-]+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,4})*$").hasMatch(email);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(' ', '');
    return phoneNumber != '' && (phoneNumber.length >= 8 && phoneNumber.length <= 10);
  }

  static bool isValidPassword(String password) {
    return password != '' && password.length >= 4;
  }

  static bool isValidConfirmPassword(String password, String confirmPass) {
    return password == confirmPass;
  }

  static final AppValidators _instance = AppValidators._internal();
  factory AppValidators() {
    return _instance;
  }
  AppValidators._internal();
}
