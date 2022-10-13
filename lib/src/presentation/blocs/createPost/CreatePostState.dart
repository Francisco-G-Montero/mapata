import 'dart:async';

import 'package:equatable/equatable.dart';

class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object?> get props => [];
}

class CreatePostLoading extends CreatePostState {
  const CreatePostLoading();
}

class CreatePostError extends CreatePostState {
  const CreatePostError();
}

class CreatePostDone extends CreatePostState {

  CreatePostDone();

  @override
  List<Object?> get props => [];
}