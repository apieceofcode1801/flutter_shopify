class NetworkException implements Exception {
  final _message;
  final _prefix;

  NetworkException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends NetworkException {
  FetchDataException([String message = ''])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends NetworkException {
  BadRequestException([message = '']) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException([message = '']) : super(message, 'Unauthosised: ');
}

class InvalidInputException extends NetworkException {
  InvalidInputException([message]) : super(message, 'Invalid input: ');
}