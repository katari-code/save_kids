import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/video_report.dart';
import 'package:save_kids/services/repository.dart';

class VideoReportingBloc extends BlocBase {
  Repository<VideoReport> _reportingRepository =
      Repository<VideoReport>(collection: 'video_reports');

  //several input streams
  BehaviorSubject<String> videoId = BehaviorSubject<String>();
  BehaviorSubject<String> report = BehaviorSubject<String>();

  //get parent session
  Stream<Parent> get parentSession {
    return _reportingRepository.authSession;
  }

  //function that adds the values to backend
  Future<VideoReport> addVideoReport(String id) async {
    final report = VideoReport(
        report: 'something',
        videoId: id,
        parentId: (await parentSession.first).id);

    return _reportingRepository.addDocument(report);
  }
}
