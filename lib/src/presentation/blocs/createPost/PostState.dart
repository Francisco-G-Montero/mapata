import 'dart:async';

import 'package:equatable/equatable.dart';

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

  PostDone();

  @override
  List<Object?> get props => [];
}