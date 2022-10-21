import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/Post.dart';
import '../../../data/util/ViewStates.dart';
import '../../../domain/usecases/remote/GetPostUseCase.dart';
import 'PostEvent.dart';
import 'PostState.dart';

class PostBloc extends Bloc<PostEvent, ViewStates> {

  final GetPostUseCase _getPostUseCase;

  PostBloc(this._getPostUseCase) : super(ViewStates.stateLoading()) {
    on<RestartPost>(_restartPost);
    on<RenderPost>(_renderPost);
  }

  FutureOr<void> _restartPost(event, emit) async {
    emit(ViewStates.stateLoading);
  }

  FutureOr<void> _renderPost(event, emit) async {
    final renderPostEvent = (event as RenderPost);
    final postResult = await _getPostUseCase(renderPostEvent.postId);
    postResult.fold((error) => null,
            (data) => {emit(StatePostDataRetrieved(data))});
  }
}
