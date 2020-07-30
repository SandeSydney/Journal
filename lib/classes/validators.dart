import 'dart:async';

class Validators {
  // variable with a method to check the validity of an email address
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@') && email.contains('.')) {
      sink.add(email);
    } else if (email.length > 0) {
      sink.addError('Enter a valid email');
    }
  });

  // variable with a method to check if a password has 6 characters
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else if (password.length > 0) {
      sink.addError('Password needs to be atleast six characters');
    }
  });
}
