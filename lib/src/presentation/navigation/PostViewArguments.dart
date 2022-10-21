import 'package:mapata/src/data/model/AnimalMarker.dart';

import '../../data/model/Post.dart';

class PostViewArguments {
  final AnimalMarker? marker;
  Post? post;
  final String? postId;

  PostViewArguments(this.marker, this.postId, this.post);
}