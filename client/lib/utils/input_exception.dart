class InputException extends ArgumentError {
  InputException(String message, String name) : super.value(null, name, message);
}