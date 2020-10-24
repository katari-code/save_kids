import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';

class VideoReport extends FireStoreConverter {
  String videoId;
  ReportType reportType;
  String id;
  String parentId;
  VideoReport({this.reportType, this.id, this.videoId, this.parentId});
  VideoReport.fromFirestore(DocumentSnapshot snapshot)
      : this(
          videoId: snapshot.data['videoId'],
          reportType: snapshot.data['report'],
          id: snapshot.documentID,
          parentId: snapshot.data['parent'],
        );
  @override
  fromFireStore(DocumentSnapshot snapshot) {
    return VideoReport.fromFirestore(snapshot);
  }

  @override
  toFireStore() {
    return {
      "videoId": this.videoId,
      'report': this.reportType,
      'parent': this.parentId
    };
  }
}

enum ReportType {
  violent,
  inappropriate,
  nudity,
  drugs,
}
