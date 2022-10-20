import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/data/model/Post.dart';
import 'package:mapata/src/data/util/MarkerUtil.dart';
import 'package:mapata/src/data/util/ViewStates.dart';
import 'package:mapata/src/domain/usecases/remote/EditPostUseCase.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostEvent.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostState.dart';

import '../../../domain/usecases/remote/CreatePostUseCase.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, ViewStates> {
  final CreatePostUseCase createPostUseCase;
  final EditPostUseCase editPostUseCase;

  CreatePostBloc(this.createPostUseCase, this.editPostUseCase) : super(ViewStates.stateLoading()) {
    on<RenderCreatePost>(_renderPost);
    on<StartCreatePost>(_createPost);
    on<EditPostEvent>(_editPost);
  }

  FutureOr<void> _renderPost(event, emit) async {
    final newState = ViewStates.stateRenderView();
    emit(newState);
  }

  FutureOr<void> _createPost(event, emit) async {
    final createEvent = (event as StartCreatePost);
    String? transitanteId;
    MarkerType markerType = MarkerType.LOST;
    createEvent.newPost.postOwnerId = ""; //TODO terminar con el ingreso
    if (createEvent.postStatus == PostStatus.TRANSITANDO) {
      //transitanteId = postOwnerId
      //si el usuario crea un post en transito markerType empieza con "TRANSITO"
      createEvent.newPost.transitanteId = createEvent.newPost.postOwnerId;
    }
    final dataResult =
        await createPostUseCase(createEvent.imageFilePath, createEvent.newPost, markerType);
    dataResult.fold((error) => null, (data) => {emit(CreatePostState.statePostCreated())});
    //TODO emit() nuevo estado
  }

  FutureOr<void> _editPost(event, emit) async {
    final editEvent = (event as EditPostEvent);
    final editResult = await editPostUseCase(editEvent.editedPost, editEvent.marker);
    editResult.fold((error) => null, (data) => {
      // TODO emit nuevo estado
    });
  }
}
