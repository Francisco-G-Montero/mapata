import '../../../data/util/ViewStates.dart';

class CreatePostState extends ViewStates {
  const CreatePostState();
  static ViewStates statePostCreated() => StatePostCreated();
}

class StatePostCreated extends ViewStates {
  StatePostCreated();
}

class StatePostEdited extends ViewStates {
  StatePostEdited();
}
