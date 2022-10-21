import 'package:equatable/equatable.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';
import 'package:mapata/src/data/util/MarkerUtil.dart';

import '../../../data/model/Post.dart';

class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class RestartPost extends PostEvent {
  const RestartPost();
}

class RenderPost extends PostEvent{
  final String postId;

  const RenderPost(this.postId);
}

class DeletePost extends PostEvent {
  final Post post;
  final AnimalMarker marker;

  const DeletePost(this.post, this.marker);
}