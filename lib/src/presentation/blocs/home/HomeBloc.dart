import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/presentation/blocs/home/HomeEvent.dart';
import 'package:mapata/src/presentation/blocs/home/HomeState.dart';
import 'package:geolocator/geolocator.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeLoading()) {
    on<InitializeMap>(_initializeMap);
  }

  FutureOr<void> _initializeMap(event, emit) async {
    Position currentLocation = const Position(
        latitude: -34.9028887,
        longitude: -57.9181257,
        isMocked: true,
        accuracy: 1,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        floor: null,
        timestamp: null
    );
    final newState = HomeDone();
    newState.homeUiModel =
        newState.homeUiModel.copyWith(currentLocation: currentLocation);
    emit(newState);
  }
}
