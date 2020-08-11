import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class SignUpBloc extends BlocBase {
  Repository _repository = new Repository<Parent>(collection: 'parent');
  SignUpBloc() {
    showProgressBar(false);
  }
  final _fullName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();

  Stream<String> get streamName => _fullName.stream.transform(_validateName);
  Stream<String> get streamEmail => _email.transform(_validateEmail);
  Stream<String> get streamPhoneNumber =>
      _phoneNumber.transform(_validatePhoneNumber);
  Stream<String> get streamPassword => _password.transform(_validatePassword);

  Function(String) get changeName => _fullName.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePhoneNumber => _phoneNumber.sink.add;
  Function(String) get changePassword => _password.sink.add;

  final _isSignedIn = BehaviorSubject<bool>();
  Function(bool) get showProgressBar => _isSignedIn.sink.add;
  Stream<bool> get signInStatus => _isSignedIn.stream;
  final _validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length > 5) {
      sink.add(data.trim());
    } else
      sink.addError('name length must be over 5 letters!');
  });
  final _validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email.trim());
    } else {
      sink.addError('Enter a proper email!');
    }
  });
  final _validatePhoneNumber =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length > 5) {
      sink.add(data.trim());
    } else
      sink.addError('name length must be over 5 letters!');
  });
  final _validatePassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length > 5) {
      sink.add(data.trim());
    } else
      sink.addError('name length must be over 5 letters!');
  });

  bool validateSignInFields() {
    if (_email.value != null &&
        _email.value.isNotEmpty &&
        _password.value != null &&
        _password.value.isNotEmpty &&
        _email.value.contains('@') &&
        _password.value.length > 5 &&
        _fullName.value != null &&
        _fullName.value.isNotEmpty &&
        _phoneNumber.value != null &&
        _phoneNumber.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<Parent> signUp() {
    Parent parent = Parent(
      email: _email.value,
      password: _password.value,
      name: _fullName.value,
    );
    return _repository.signUp(parent);
  }

  @override
  void dispose() async {
    await _fullName.drain();
    _fullName.close();
    await _email.drain();
    _email.close();
    await _phoneNumber.drain();
    _phoneNumber.close();
    await _password.drain();
    _password.close();
    await _isSignedIn.drain();
    super.dispose();
  }
}
