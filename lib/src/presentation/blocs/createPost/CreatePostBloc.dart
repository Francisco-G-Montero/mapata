import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/data/model/Post.dart';
import 'package:mapata/src/data/util/MarkerUtil.dart';
import 'package:mapata/src/data/util/ViewStates.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostEvent.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostState.dart';

import '../../../domain/usecases/remote/CreatePostUseCase.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, ViewStates> {
  final CreatePostUseCase createPostUseCase;

  CreatePostBloc(this.createPostUseCase) : super(ViewStates.stateLoading()) {
    on<RenderCreatePost>(_renderPost);
    on<StartCreatePost>(_createPost);
  }

  FutureOr<void> _renderPost(event, emit) async {
    final newState = ViewStates.stateRenderView();
    emit(newState);
  }

  FutureOr<void> _createPost(event, emit) async {
    final createEvent = (event as StartCreatePost);
    String? transitanteId;
    MarkerType markerType = MarkerType.LOST;
    if (createEvent.postState == PostStatus.TRANSITANDO) {
      //transitanteId = postOwnerId
      //markerType empieza con "TRANSITO"
    }
    final dataResult = await createPostUseCase(
        createEvent.imageBitmap,
        createEvent.title,
        createEvent.description,
        createEvent.age,
        createEvent.gender,
        "",
        transitanteId,
        markerType);
    dataResult.fold(
            (error) => null,
            (data) => {
              emit(CreatePostState.statePostCreated())
            });
  }
}
