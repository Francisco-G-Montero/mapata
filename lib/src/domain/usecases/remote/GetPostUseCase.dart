import '../../../data/model/Post.dart';
import '../../../data/util/NetResult.dart';
import '../../repository/PostRepository.dart';

class GetPostUseCase {
  final PostRepository _postRepository;

  GetPostUseCase(
      this._postRepository);

  Future<DataResult<Post>> call(String postId) async {
    return _postRepository.getPostById(postId);
  }
}