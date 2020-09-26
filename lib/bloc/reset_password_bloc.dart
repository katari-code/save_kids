import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class ResetPasswordBloc extends BlocBase {
  Repository _repository = Repository<Parent>(collection: 'parent');
  ResetPasswordBloc() {
    isSentEmail.add(true);
    isCodeVerified.add(true);
    loading.add(false);
  }
  BehaviorSubject<String> newPassword = BehaviorSubject<String>();
  BehaviorSubject<String> code = BehaviorSubject<String>();
  BehaviorSubject<String> email = BehaviorSubject<String>();
  BehaviorSubject<bool> isSentEmail = BehaviorSubject<bool>();
  BehaviorSubject<bool> loading = BehaviorSubject<bool>();
  BehaviorSubject<bool> isCodeVerified = BehaviorSubject<bool>();

  Future<void> get sendEmail async {
    isSentEmail.add(await _repository.resetPassword(email.value));
  }

  Future<void> get verifyCode async {
    isCodeVerified.add(
        await _repository.confirmResetPassword(code.value, newPassword.value));
  }

  Stream<String> get emailStream => email.stream.transform(_validateEmail);
  Stream<String> get codeStream => code.stream.transform(_validateCode);
  Stream<String> get passwordStream =>
      newPassword.stream.transform(_validatePassword);

  //validator functions
  final _validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email.trim());
    } else {
      sink.addError('Enter a proper email!');
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5) {
      sink.add(password.trim());
    } else {
      sink.addError('password should be more than 5');
    }
  });
  final _validateCode =
      StreamTransformer<String, String>.fromHandlers(handleData: (code, sink) {
    if (code.length > 1) {
      sink.add(code.trim());
    } else {
      sink.addError('code should not be empty');
    }
  });

  bool validateFields() {
    if (newPassword.value != null &&
        newPassword.value.isNotEmpty &&
        newPassword.value.length > 5 &&
        code.value != null &&
        code.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool validateEmail() {
    if (email.value != null &&
        email.value.isNotEmpty &&
        email.value.contains('@')) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    newPassword.close();
    code.close();
    email.close();
    isSentEmail.close();
    isCodeVerified.close();
    loading.close();
    super.dispose();
  }
}
