import 'package:mapata/src/data/model/AnimalMarker.dart';

import '../../../data/model/Post.dart';
import '../../../data/util/NetResult.dart';
import '../../repository/AnimalMarkersRepository.dart';
import '../../repository/PostRepository.dart';

class EditPostUseCase {
  final PostRepository _postRepository;
  final AnimalMarkersRepository _animalMarkersRepository;

  EditPostUseCase(
      this._postRepository, this._animalMarkersRepository);

  Future<DataResult<void>> call(Post post, AnimalMarker animalMarker) async {
    animalMarker.title = post.title;
    animalMarker.description = post.description;
    final markerResult = await _animalMarkersRepository.updateAnimalMarker(animalMarker);
    if(markerResult.isSuccess) {
      return _postRepository.updatePost(post);
    }
    return DataResult.failure(GenericFailure());
  }
}