import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:mapata/src/presentation/blocs/viewPost/PostState.dart';

class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

class RenderCreatePost extends CreatePostEvent{
  const RenderCreatePost();
}

class StartCreatePost extends CreatePostEvent{
  final File imageBitmap;
  final String title;
  final String description;
  final String age;
  final String gender;
  final PostState postState;

  const StartCreatePost(this.imageBitmap, this.title, this.description, this.age, this.gender, this.postState);
}