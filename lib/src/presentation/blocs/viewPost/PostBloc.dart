import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/Post.dart';
import 'PostEvent.dart';
import 'PostState.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  PostBloc() : super(const PostLoading()) {
    on<RenderPost>(_renderPost);
  }

  FutureOr<void> _renderPost(event, emit) async {
    Post post = Post(
        date: DateTime.now(),
        imageUrl: "https://external-preview.redd.it/H_HYJyRcbV4YT1UZee3P4w0lfKeBmDEhLH2HWEWWY0Y.png?format=pjpg&auto=webp&s=9f64a2788bd32dfa8bcb9df259412bf2a085978d",
        title: "Preston Smith",
        description: "description",
        age: 35,
        gender: "gender",
        postOwnerId: "postOwnerId",
        transitanteId: "transitanteId",
        adopterId: "adopterId");
    final newState = PostDone(post: post);
    emit(newState);
  }
}
