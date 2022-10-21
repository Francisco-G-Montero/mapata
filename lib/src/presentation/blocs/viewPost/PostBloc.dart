import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/domain/usecases/remote/DeletePostUseCase.dart';
import '../../../data/model/Post.dart';
import '../../../data/util/ViewStates.dart';
import '../../../domain/usecases/remote/GetPostUseCase.dart';
import 'PostEvent.dart';
import 'PostState.dart';

class PostBloc extends Bloc<PostEvent, ViewStates> {
  final GetPostUseCase _getPostUseCase;
  final DeletePostUseCase _deletePostUseCase;

  PostBloc(this._getPostUseCase, this._deletePostUseCase) : super(ViewStates.stateLoading()) {
    on<RestartPost>(_restartPost);
    on<RenderPost>(_renderPost);
    on<DeletePost>(_deletePost);
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

  FutureOr<void> _deletePost(event, emit) async {
    final deletePostEvent = (event as DeletePost);
    final postResult = await _deletePostUseCase(deletePostEvent.post, deletePostEvent.marker);
    postResult.fold((error) => null,
            (data) => {emit(StatePostDeleted())});
  }
}
