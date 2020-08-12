// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:save_kids/models/child.dart';
// import 'package:save_kids/models/parent.dart';
// import 'package:save_kids/models/timer.dart';
// import 'package:save_kids/services/repository.dart';

// class Childexploratory extends BlocBase {
//   String idChild;
//   Childexploratory() {}

//   Repository _repository = Repository<Child>(collection: 'children');
//   BehaviorSubject<Timer> timer = BehaviorSubject<Timer>();

//   Stream<Child> get getChild {
//     return _repository.getDocument(Child(), idChild);
//   }

//   Stream<Parent> get parentSession => _repository.authSession;
//   Stream<Timer></Timer> get changeTimer {
//     getChild.switchMap((child) {
//       if (child != null) {
//         timer.add(child.timer);
//         return timer.stream; //_timer
//       } else {
//         return BehaviorSubject.seeded(0);
//       }
//     });

//     // parentSession.switchMap((parent) {
//     //   if (parent != null) {
//     //     return _repository.getDocumentByQuery(Child(), id)
//     //   }
//     // });
//   }

//   // @override
//   void dispose() async {
//     // await _childName.drain();
//     // _childName.close();
//     // await _timer.drain();
//     // _timer.close();
//     // await _imageAvatar.drain();
//     // _imageAvatar.close();
//     super.dispose();
//   }
// }
