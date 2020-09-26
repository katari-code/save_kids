import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class ParentSettingsBloc extends BlocBase {
  Repository _repository = Repository<Parent>(collection: 'parent');
  ParentSettingsBloc() {
    showProgressBar(false);
    isAuthorised.add(false);
    parent.addStream(parentSession.switchMap((session) {
      if (session != null) return getParent(session);
      return BehaviorSubject.seeded(null);
    }));
  }
  bool isInitial = true;
  BehaviorSubject<String> email = BehaviorSubject<String>();
  BehaviorSubject<String> password = BehaviorSubject<String>();
  BehaviorSubject<String> name = BehaviorSubject<String>();
  BehaviorSubject<Parent> parent = BehaviorSubject<Parent>();
  BehaviorSubject<bool> isAuthorised = BehaviorSubject<bool>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();
  //onChanged Functions
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(bool) get showProgressBar => _isSignedIn.sink.add;

  //stream functions
  Stream<String> get signEmail => _email.stream.transform(_validateEmail);
  Stream<String> get singPassword =>
      _password.stream.transform(_validatePassword);
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
  Future<bool> signIn() {
    return _repository.verifyAccount(_email.value, _password.value);
  }

  Future<bool> signInWithGoogle() async {
    return await _repository.verifyAccountWithGoogle();
    //store the data
  }

  Stream<Parent> get parentSession => _repository.authSession;
  Stream<Parent> getParent(Parent parentSession) {
    return _repository.getDocument(Parent(), parentSession.id);
  }

  initiateValues(Parent parent) {
    if (isInitial) {
      email.add(parent.email);
      password.add(parent.password);
      name.add(parent.name);
      isInitial = false;
    }
  }

  Future updateUser() async {
    //update user from auth

    Parent updatedParent = Parent(
        email: email.value.trim(),
        password:
            password.value == null ? password.value : password.value.trim(),
        name: name.value.trim());
    await _repository.updateCurrentUser(updatedParent);
    //update the data in firebase
    return await _repository.setDocument(updatedParent, parent.value.id);
  }

  @override
  void dispose() {
    _email.close();
    _password.close();
    _isSignedIn.close();
    isInitial = true;
    name.close();

    isAuthorised.close();
    super.dispose();
  }
}
