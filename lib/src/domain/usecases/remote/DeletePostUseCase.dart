import '../../../data/model/Post.dart';
import '../../../data/util/NetResult.dart';
import '../../repository/AnimalMarkersRepository.dart';
import '../../repository/PostRepository.dart';
import '../../repository/StorageRepository.dart';

class DeletePostUseCase {
  final PostRepository _postRepository;
  final StorageRepository _imageStorageRepository;
  final AnimalMarkersRepository _animalMarkersRepository;

  DeletePostUseCase(
      this._postRepository, this._imageStorageRepository, this._animalMarkersRepository);

  Future<DataResult<void>> call(Post post) async {
    final deleteResult = await _imageStorageRepository.deletePostImage(post.imageUrl);
    if(deleteResult.isSuccess){
      //_animalMarkersRepository
    }
    return DataResult.failure(GenericFailure());
  }
}
