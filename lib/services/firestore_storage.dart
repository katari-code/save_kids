import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreStorageProvider {
  String imageURL;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFile(File imageFile) async {
    StorageReference storageReference =
        storage.ref().child(Path.basename(imageFile.path));

    print('uploading..');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);

    //waiting for the image to upload
    await uploadTask.onComplete;
    print('File Uploaded');
    imageURL = await storageReference.getDownloadURL();
    print('in uploading area $imageURL');
    return imageURL;
  }
  // String get imageURL{

  // }
}
