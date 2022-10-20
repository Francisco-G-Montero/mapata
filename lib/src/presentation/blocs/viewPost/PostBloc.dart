import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/Post.dart';
import '../../../data/util/ViewStates.dart';
import 'PostEvent.dart';
import 'PostState.dart';

class PostBloc extends Bloc<PostEvent, ViewStates> {

  PostBloc() : super(ViewStates.stateLoading()) {
    on<RenderPost>(_renderPost);
  }

  FutureOr<void> _renderPost(event, emit) async {
    Post post = Post(
        date: DateTime.now(),
        imageUrl: "https://external-preview.redd.it/H_HYJyRcbV4YT1UZee3P4w0lfKeBmDEhLH2HWEWWY0Y.png?format=pjpg&auto=webp&s=9f64a2788bd32dfa8bcb9df259412bf2a085978d",
        title: "Preston Smith",
        description: "description",
        age: "Viejo",
        gender: "Femenino",
        postOwnerId: "postOwnerId",
        transitanteId: "transitanteId",
        adopterId: "adopterId");
    final newState = StatePostDataRetrieved(post);
    emit(newState);
  }
}
