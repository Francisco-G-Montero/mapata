import '../../../data/model/Post.dart';
import '../../../data/util/ViewStates.dart';

class PostState extends ViewStates {
  const PostState();

  static ViewStates statePostDataRetrieved(Post post) => StatePostDataRetrieved(post);
}

class StatePostDataRetrieved extends ViewStates {
  final Post post;

  const StatePostDataRetrieved(this.post);

  @override
  List<Object?> get props => [post];
}

class StatePostDeleted extends ViewStates {
  const StatePostDeleted();
}