import 'package:equatable/equatable.dart';

class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

class RenderCreatePost extends CreatePostEvent{
  const RenderCreatePost();
}

class StartCreatePost extends CreatePostEvent{
  const StartCreatePost();
}