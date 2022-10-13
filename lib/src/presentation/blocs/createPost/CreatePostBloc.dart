import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostEvent.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostState.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {

  CreatePostBloc() : super(const CreatePostLoading()) {
    on<RenderCreatePost>(_renderPost);
    on<StartCreatePost>(_createPost);
  }

  FutureOr<void> _renderPost(event, emit) async {
    final newState = CreatePostDone();
    emit(newState);
  }

  FutureOr<void> _createPost(event, emit) async { }
}
