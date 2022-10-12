import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/PostEvent.dart';
import 'package:mapata/src/presentation/blocs/createPost/PostState.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  PostBloc() : super(const PostLoading()) {
    on<RenderPost>(_renderPost);
    on<CreatePost>(_createPost);
  }

  FutureOr<void> _renderPost(event, emit) async {
    final newState = PostDone();
    emit(newState);
  }

  FutureOr<void> _createPost(event, emit) async { }
}
