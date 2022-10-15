import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../../data/model/Post.dart';

class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {
  const PostLoading();
}

class PostError extends PostState {
  const PostError();
}

class PostDone extends PostState {
  Post post;

  PostDone({required this.post});

  @override
  List<Object?> get props => [post];
}