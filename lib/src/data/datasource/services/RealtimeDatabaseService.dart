import 'package:firebase_database/firebase_database.dart';

const String markersRef = "markers";
const String postsRef = "posts";

class RealtimeDatabaseService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  DatabaseReference getMarkersReference() {
    return database.ref(markersRef);
  }

  DatabaseReference getMarkerReference(String markerId) {
    return database.ref('$markersRef/$markerId');
  }

  DatabaseReference getPostsReference() {
    return database.ref(postsRef);
  }

  DatabaseReference getPostReference(String postId) {
    return database.ref('$postsRef/$postId');
  }
}