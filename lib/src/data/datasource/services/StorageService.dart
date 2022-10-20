import 'package:firebase_storage/firebase_storage.dart';

const String imagePostsRef = "imagePosts";

class StorageService {
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Reference getImagePostReference() {
    return storage.ref('imagePostsRef/${generateTokenKey()}');
  }

  Reference getImagePostById(String path) {
    return storage.ref('imagePostsRef/$path');
  }

  String generateTokenKey() {
    return DateTime.now().toString();
  }
}