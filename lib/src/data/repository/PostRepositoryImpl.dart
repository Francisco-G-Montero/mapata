import 'package:mapata/src/data/datasource/remote/PostDatabase.dart';
import 'package:mapata/src/data/model/Post.dart';
import 'package:mapata/src/data/util/NetResult.dart';
import 'package:mapata/src/domain/repository/PostRepository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostsDatabase _postsDatabase;

  PostRepositoryImpl(this._postsDatabase);

  @override
  Future<DataResult<String>> createPost(Post post) {
    return _postsDatabase.createPost(post);
  }

  @override
  Future<DataResult<Post>> getPostById(String postId) {
    return _postsDatabase.getPostById(postId);
  }

  @override
  Future<DataResult<void>> updatePost(Post post) {
    return _postsDatabase.updatePost(post);
  }
}