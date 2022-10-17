import 'package:firebase_storage/firebase_storage.dart';

const String imagePostsRef = "imagePosts";

class StorageService {
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Reference getImagePostReference() {
    return storage.ref('imagePostsRef/${generateTokenKey()}');
  }

  String generateTokenKey() {
    return DateTime.now().toString();
  }
}