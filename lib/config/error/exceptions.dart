import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? msg;

  const ServerException([this.msg]);

  @override
  List<Object?> get props => [msg];

  @override
  String toString() => "$msg";
}

class InvalidLoginCredentials extends ServerException {
  const InvalidLoginCredentials([msg]) : super("Invalid email or password");
}

class UserNotFound extends ServerException {
  const UserNotFound([msg]) : super("User not found");
}

class InvalidPassword extends ServerException {
  const InvalidPassword([msg]) : super("Invalid password");
}

class InvalidEmailFormat extends ServerException {
  const InvalidEmailFormat([msg]) : super("Email format is not valid");
}

class EmailInUse extends ServerException {
  const EmailInUse([msg]) : super("Email already has an account");
}

class InvalidPhoneNumber extends ServerException {
  const InvalidPhoneNumber([msg]) : super("Invalid phone number");
}

class TooManyRequests extends ServerException {
  const TooManyRequests([msg]) : super("Too many requests. Try again later");
}

class UnknownError extends ServerException {
  const UnknownError([msg]) : super("Unknown error $msg");
}

class ConnectionError extends ServerException {
  const ConnectionError([msg]) : super("Connection error");
}

class PermissionDenied extends ServerException {
  const PermissionDenied([msg]) : super("Permission denied");
}
