class Failure {
  Failure({this.msg});
  String? msg;
}

class NetworkFailure extends Failure {}

// unexpected error
class UnexpectedFailure extends Failure {}
// class UnExcepected extends Failure {}
