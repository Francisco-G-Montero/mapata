import 'dart:html';

import '../../data/model/Post.dart';
import '../../data/util/NetResult.dart';

abstract class PostRepository {
  Future<DataResult<Post>> getPostById(String postId);
  Future<DataResult<String>> createPost(Post post);
}