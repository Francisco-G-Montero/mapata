import 'package:equatable/equatable.dart';

class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class RenderPost extends PostEvent{
  const RenderPost();
}

class CreatePost extends PostEvent{
  const CreatePost();
}