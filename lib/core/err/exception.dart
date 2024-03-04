import 'package:clean_arch_movie_app/core/err/failures.dart';
import 'package:easy_localization/easy_localization.dart';

///One Exception can be many failures
class ServerException {
  final String? message;
  ServerException({this.message});
}

class NetWorkException {
  final NetworkFailure failure;
  NetWorkException(this.failure);
}

class CacheException {
  final String message;
  CacheException(this.message);
}

class ErrorHandler {
  ///map err from server to correct

  static final errors = {
    "Email or password is incorrect": 'email_or_pass_incorrect'.tr(),
    "Token expired": 'token_expired'.tr(),
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
      return defaultError ?? 'an_error_has_occured'.tr();
    }
    return errors.containsKey(error) ? errors[error] : error;
  }
}
