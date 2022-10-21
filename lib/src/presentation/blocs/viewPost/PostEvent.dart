import 'package:equatable/equatable.dart';

class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class RenderPost extends PostEvent{
  final String postId;

  const RenderPost(this.postId);
}