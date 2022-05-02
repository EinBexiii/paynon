
import 'package:equatable/equatable.dart';

class Failure implements Exception {
  final String message;

  const Failure({this.message = ""});

  @override
  String toString() => "Failure { message: $message}";
}
