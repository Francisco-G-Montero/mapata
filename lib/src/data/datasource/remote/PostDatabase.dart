import 'package:firebase_database/firebase_database.dart';
import 'package:mapata/src/data/util/NetResult.dart';

import '../../model/Post.dart';
import '../services/RealtimeDatabaseService.dart';

class PostsDatabase {
  final RealtimeDatabaseService databaseService;

  PostsDatabase(this.databaseService);

  Future<DataResult<Post>> getPostById(String postId) async {
    Post? post;
    await databaseService.getPostReference(postId).get().then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.value != null) {
          final dataValue = new Map<String, dynamic>.from(snapshot.value as Map);
          post = Post.fromJson(dataValue);
          post!.id = snapshot.key!;
        }
      }
    });
    return post != null ? DataResult.success(post!) : DataResult.failure(GenericFailure());
  }

  Future<DataResult<String>> createPost(Post post) async {
    DatabaseReference newPostRef = await databaseService.getPostsReference().push();
    try {
      await databaseService.getPostReference(newPostRef.key!).set(post);
      return DataResult.success(newPostRef.key!);
    } catch (error) {
      return DataResult.failure(GenericFailure());
    }
  }

  Future<DataResult<void>> updatePost(Post post) async {
    try {
      await databaseService.getPostReference(post.id).update(post.toJson());
      return DataResult.success(null);
    } catch (error) {
      return DataResult.failure(GenericFailure());
    }
  }
}
