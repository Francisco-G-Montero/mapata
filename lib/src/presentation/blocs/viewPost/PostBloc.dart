import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'PostEvent.dart';
import 'PostState.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  PostBloc() : super(const PostLoading()) {
    on<RenderPost>(_renderPost);
  }

  FutureOr<void> _renderPost(event, emit) async {
    final newState = PostDone();
    emit(newState);
  }
}
