class UserException implements Exception {
  final String message;

  UserException(this.message)
      : assert(message != null, "error Message can not be null ");

  @override String toString() => message;
}
