import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';
import 'package:mapata/src/presentation/blocs/viewPost/PostState.dart';

import '../../../data/model/Post.dart';

class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

class RenderCreatePost extends CreatePostEvent{
  const RenderCreatePost();
}

class StartCreatePost extends CreatePostEvent{
  final File imageFilePath;
  final Post newPost;
  final PostStatus postStatus;

  const StartCreatePost(this.imageFilePath, this.newPost, this.postStatus);
}

class EditPostEvent extends CreatePostEvent{
  final Post editedPost;
  final AnimalMarker marker;
  final PostStatus postState;

  const EditPostEvent(this.editedPost, this.postState, this.marker);
}