import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class InitializeMap extends HomeEvent{
  const InitializeMap();
}

class LoadMarkers extends HomeEvent{
  const LoadMarkers();
}