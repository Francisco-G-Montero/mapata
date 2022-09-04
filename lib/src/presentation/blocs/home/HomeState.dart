import 'package:equatable/equatable.dart';

import 'HomeUiModel.dart';


class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeError extends HomeState {
  const HomeError();
}

class HomeDone extends HomeState {
  HomeUiModel homeUiModel;

  HomeDone({this.homeUiModel = const HomeUiModel()});

  @override
  List<Object?> get props => [homeUiModel];

  HomeDone copyWith({
    HomeUiModel? homeUiModel,
  }) {
    return HomeDone(
      homeUiModel: homeUiModel ?? this.homeUiModel,
    );
  }
}