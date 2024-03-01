class ServerException {
  final String message;
  ServerException(this.message);
}

class CacheException {
  final String message;
  CacheException(this.message);
}

class ErrorHandler {
  ///map err from server to correct

  static final errors = {
    "Email or password is incorrect": "Email or password is incorrect",
    "Your card's security code is invalid.": "Your card's security code is invalid",
    "Token expired": "Token expired",
    '"email" must be a valid email': '"email" must be a valid email',
    "Access token is expired": "Access token is expired",
  };

  static String? parse(String error, {bool shouldUseDefaultError = true, String? defaultError}) {
    ///remove some text in err to show correct err
    if (error.indexOf("E_NGW001") == 0) {
      return error.replaceAll("E_NGW001", "");
    }
    if (error.indexOf("E_ACC002") == 0) {
      return error.replaceAll("E_ACC002", "");
    }
    if (error.indexOf("E_ACC004") == 0) {
      return error.replaceAll("E_ACC004", "");
    }
    if (error.indexOf("E_SEN001") == 0) {
      return error.replaceAll("E_SEN001", "");
    }
    if (defaultError != null || shouldUseDefaultError) {
      return defaultError ?? "エラーが発生しました";
    }
    return errors.containsKey(error) ? errors[error] : error;
  }
}
