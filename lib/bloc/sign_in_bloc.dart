import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class SignInBloc extends BlocBase {
  Repository _repository = new Repository<Parent>(collection: 'parent');
  //input sink stream objects
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();

  SignInBloc() {
    showProgressBar(false);
  }

  //onChanged Functions
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(bool) get showProgressBar => _isSignedIn.sink.add;

  //stream functions
  Stream<String> get email => _email.stream.transform(_validateEmail);
  Stream<String> get password => _password.stream.transform(_validatePassword);
  Stream<bool> get signInStatus => _isSignedIn.stream;

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

  bool validateSignInFields() {
    if (_email.value != null &&
        _email.value.isNotEmpty &&
        _password.value != null &&
        _password.value.isNotEmpty &&
        _email.value.contains('@') &&
        _password.value.length > 5) {
      return true;
    } else {
      return false;
    }
  }

  //sign in
  Future<dynamic> signIn() {
    return _repository.signIn(_email.value, _password.value);
  }

  Future<Parent> signInWithGoogle() async {
    final parent = await _repository.signInWithGoogle();
    //store the data
    return _repository.setDocument(parent, parent.id);
  }

  Future<void> signOut() {
    return _repository.logout();
  }

  //close streams and sinks after login
  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
    super.dispose();
  }
}
