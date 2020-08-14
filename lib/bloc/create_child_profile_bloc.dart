import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/services/repository.dart';

class CreateChildProfileBloc extends BlocBase {
  CreateChildProfileBloc() {
    _imageAvatar.sink.add(avatars[0]);
    _timer.sink.add(timers[0]);
  }
  Repository _repository = Repository<Child>(collection: 'children');
  // final _isEditMode = BehaviorSubject<bool>();
  final _childName = BehaviorSubject<String>();
  final _age = BehaviorSubject<String>();
  final _imageAvatar = BehaviorSubject<String>();
  final _timer = BehaviorSubject<Timer>();

  Function(String) get changeChildName => _childName.sink.add;
  Function(Timer) get changeTimer => _timer.sink.add;
  Function(String) get changeAge => _age.sink.add;
  // Function(bool) get changeEditMode => _isEditMode.sink.add;
  Function(String) get changeImageAvatar => _imageAvatar.sink.add;

  Stream<String> get childName => _childName.stream;
  Stream<String> get age => _age.stream;
  // Stream<bool> get editMode => _isEditMode.stream;
  Stream<String> get imageAvatar => _imageAvatar.stream;
  Stream<Timer> get timer => _timer.stream;

  Stream<Parent> get parentSession => _repository.authSession;

  Future<Child> addChild(String parentId, String type) async {
    Child child = Child(
      name: _childName.value,
      type: type,
      parentId: parentId,
      imagePath: _imageAvatar.value,
      age: _age.value,
      timer: _timer.value,
    );
    return await _repository.addDocument(child);
  }

  @override
  void dispose() async {
    // await _isEditMode.drain();

    await _childName.drain();
    _childName.close();
    await _age.drain();
    _age.close();
    await _timer.drain();
    _timer.close();
    await _imageAvatar.drain();
    _imageAvatar.close();
    super.dispose();
  }

  final List<String> avatars = [
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-01.png?alt=media&token=aeb3748f-ff44-4628-921b-4268aea1c378",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-02.png?alt=media&token=42e692af-8d9c-48cf-8142-02e1548e2465",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-03.png?alt=media&token=657ad3ac-7dd4-4bc2-b3d2-71f90e9852e4",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-01.png?alt=media&token=5933af5f-3e97-4ae0-b09d-c73f5b84d630",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-02.png?alt=media&token=d80f18e6-6310-487c-8fe7-53fc08a9a1eb",
    "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-03.png?alt=media&token=e6c687d8-63aa-46a6-a2d5-ccc87daf3432",
  ];
  final List<Timer> timers = [
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
        lableText: "1 hr",
        lengthSec: (60 * 60 * 60),
        remainSec: (60 * 60 * 60),
        isComplete: false),
    Timer(
        lableText: "1:30 hr",
        lengthSec: (90 * 60 * 60),
        remainSec: (90 * 60 * 60),
        isComplete: false),
  ];
}
