import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';

class VideoReport extends FireStoreConverter {
  String videoId;
  ReportType reportType;
  String id;
  VideoReport({this.reportType, this.id, this.videoId});
  VideoReport.fromFirestore(DocumentSnapshot snapshot)
      : this(
            videoId: snapshot.data['videoId'],
            reportType: snapshot.data['report'],
            id: snapshot.documentID);
  @override
  fromFireStore(DocumentSnapshot snapshot) {
    return VideoReport.fromFirestore(snapshot);
  }

  @override
  toFireStore() {
    return {
      "videoId": this.videoId,
      'report': this.reportType,
    };
  }
}

enum ReportType {
  violent,
  inappropriate,
  nudity,
  drugs,
}
