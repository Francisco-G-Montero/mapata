import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';
import 'package:mapata/src/data/util/MarkerUtil.dart';
import 'package:mapata/src/domain/repository/AnimalMarkersRepository.dart';
import 'package:mapata/src/domain/repository/StorageRepository.dart';
import 'package:mapata/src/domain/repository/PostRepository.dart';

import '../../../data/datasource/services/GeolocationService.dart';
import '../../../data/model/Post.dart';
import '../../../data/util/NetResult.dart';

class CreatePostUseCase {
  final PostRepository _postRepository;
  final StorageRepository _imageStorageRepository;
  final AnimalMarkersRepository _animalMarkersRepository;
  final GeolocationService _geolocationService;

  CreatePostUseCase(this._postRepository, this._imageStorageRepository, this._geolocationService,
      this._animalMarkersRepository);

  //postOwnerId lo agregamos cuando incorporemos login
  Future<DataResult<void>> call(
      File postImage,
      Post newPost,
      MarkerType markerType) async {
    var imageResult = await _imageStorageRepository.uploadPostImage(postImage.path);
    if (imageResult.isSuccess) {
      //si la imagen se subio bien continuamos con la creacion del post
      DateTime date = DateTime.now();
      Post post = Post(
          date: date,
          imageUrl: imageResult.data!,
          title: newPost.title,
          description: newPost.description,
          age: newPost.age,
          gender: newPost.gender,
          postStatus: newPost.postStatus,
          postOwnerId: newPost.postOwnerId,
          transitanteId: newPost.transitanteId,
          adopterId: null);
      //si se creo un post, subir post y crear marcador
      var postResult = await _postRepository.createPost(post);
      if (postResult.isSuccess) {
        Position currentLocation = await _geolocationService.getCurrentLocation();
        AnimalMarker animalMarker = AnimalMarker(
            lat: currentLocation.latitude,
            lng: currentLocation.longitude,
            title: newPost.title,
            description: newPost.description,
            imageUrl: MarkerUtil.getMarkerImageByType(markerType),
            postId: postResult.data!);
        var animalMarkerResult = await _animalMarkersRepository.createAnimalMarker(animalMarker);
        if (animalMarkerResult.isSuccess) {
          return DataResult.success(null);
        }
      }
      return DataResult.failure(GenericFailure());
    } else {
      return DataResult.failure(GenericFailure());
    }
  }
}
