import 'package:equatable/equatable.dart';

abstract class ViewStates extends Equatable {
  const ViewStates();

  static ViewStates stateLoading() => StateLoading();
  static ViewStates stateError() => StateError();
  static ViewStates stateRenderView() => StateRenderView();

  @override
  List<Object?> get props => [];
}

class StateLoading extends ViewStates {
  const StateLoading();
}

class StateError extends ViewStates {
  const StateError();
}

class StateRenderView extends ViewStates {
  const StateRenderView();
}