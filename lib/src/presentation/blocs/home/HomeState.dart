import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';

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
  StreamController? streamController;

  HomeDone({this.homeUiModel = const HomeUiModel(), required this.streamController});

  @override
  List<Object?> get props => [homeUiModel];

  HomeDone copyWith({
    HomeUiModel? homeUiModel,
    StreamController? streamController,
  }) {
    return HomeDone(
      homeUiModel: homeUiModel ?? this.homeUiModel,
      streamController: streamController ?? this.streamController,
    );
  }
}