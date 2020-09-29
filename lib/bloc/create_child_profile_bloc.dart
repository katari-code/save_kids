import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/services/repository.dart';

class CreateChildProfileBloc extends BlocBase {
  CreateChildProfileBloc() {
    _imageAvatar.sink.add(avatars[0]);
    _isValidated.add(false);
  }
  Repository _repository = Repository<Child>(collection: 'children');
  final _childName = BehaviorSubject<String>();
  final _age = BehaviorSubject<String>();
  final _imageAvatar = BehaviorSubject<String>();
  final _timer = BehaviorSubject<Timer>();
  final _isValidated = BehaviorSubject<bool>();
  Function(String) get changeChildName => _childName.sink.add;
  Function(Timer) get changeTimer => _timer.sink.add;
  Function(String) get changeAge => _age.sink.add;
  Function(String) get changeImageAvatar => _imageAvatar.sink.add;
  Function(bool) get showProgressBar => _isValidated.sink.add;
  Stream<String> get childName => _childName.stream;
  Stream<String> get age => _age.stream;
  Stream<String> get imageAvatar => _imageAvatar.stream;
  Stream<Timer> get timer => _timer.stream;
  Stream<bool> get validatedStatus => _isValidated.stream;
  // Function(bool) get changeEditMode => _isEditMode.sink.add;
  // Stream<bool> get editMode => _isEditMode.stream;
  Stream<Parent> get parentSession => _repository.authSession;

  bool validateCreateChild() {
    if (_childName.value != null && _childName.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<Child> addChild(String parentId, String type) async {
    Child child = Child(
      name: _childName.value,
      type: type,
      parentId: parentId,
      imagePath: _imageAvatar.value,
      age: _age.value,
      timer: _timer.value,
    );
    _timer.sink.add(timers[0]);
    return await _repository.addDocument(child);
  }

  @override
  void dispose() {
    // _childName.add('');
    // _age.add(null);
    // _imageAvatar.add(avatars[0]);
    // _timer.sink.add(timers[0]);
    // _isValidated.add(false);
    _childName.close();
    _age.close();
    _imageAvatar.close();
    _timer.sink.close();
    _isValidated.close();
    super.dispose();
  }

  final List<String> avatars = [
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset1.png?alt=media&token=d2fd0566-1d99-412e-a010-a17bab977f64",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset2.png?alt=media&token=9b06e088-a686-48f7-a6ca-3782ae4e7ab2",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset3.png?alt=media&token=c65a4c6e-16de-480f-a1da-47f0e8e7ea80",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset4.png?alt=media&token=f0c753f1-440a-4baf-899d-575f3d7362a4",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset5.png?alt=media&token=9dd512c4-8ba4-40dc-9bc2-4fb1bff7b749",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset6.png?alt=media&token=4d14567a-6c48-4a98-aca0-350d40da76e6",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset7.png?alt=media&token=7062daff-31a5-4d22-a009-7eda81882036",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset8.png?alt=media&token=fe5a8689-ce76-4b0d-8573-5011a6890c4f",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset9.png?alt=media&token=531d2cf8-227e-41e2-b2fa-c1b959129fe2",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset10.png?alt=media&token=8bf72423-f52a-4fb0-9a18-be53685df04c",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset11.png?alt=media&token=b04157b2-9f8d-4d91-ad6f-f722672b8052",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/Asset12.png?alt=media&token=4ac51112-6c09-4b17-9b9c-ebfbdd0bd28f",
  ];
  final List<Timer> timers = [
    Timer(
        lableText: "60 sec",
        lengthSec: (60),
        remainSec: (60),
        isComplete: false),
    Timer(
        lableText: "05 mins",
        lengthSec: (5 * 60),
        remainSec: (5 * 60),
        isComplete: false),
    Timer(
        lableText: "10 mins",
        lengthSec: (10 * 60),
        remainSec: (10 * 60),
        isComplete: false),
    Timer(
        lableText: "20 mins",
        lengthSec: (20 * 60),
        remainSec: (20 * 60),
        isComplete: false),
    Timer(
        lableText: "30 mins",
        lengthSec: (30 * 60),
        remainSec: (30 * 60),
        isComplete: false),
    Timer(
        lableText: "1:00 hr",
        lengthSec: (60 * 60),
        remainSec: (60 * 60),
        isComplete: false),
    Timer(
        lableText: "1:30 hr",
        lengthSec: (90 * 60),
        remainSec: (90 * 60),
        isComplete: false),
    Timer(
        lableText: "2:00 hr",
        lengthSec: (120 * 60),
        remainSec: (120 * 60),
        isComplete: false),
    Timer(
        lableText: "2:30 hr",
        lengthSec: (150 * 60),
        remainSec: (150 * 60),
        isComplete: false),
  ];
}
