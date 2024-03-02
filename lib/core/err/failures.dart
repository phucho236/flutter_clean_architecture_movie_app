import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure(this.message);
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String? message}) : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message) : super(message);
}
