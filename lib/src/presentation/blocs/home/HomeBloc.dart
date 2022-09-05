import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/presentation/blocs/home/HomeEvent.dart';
import 'package:mapata/src/presentation/blocs/home/HomeState.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/model/AnimalMarker.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeLoading()) {
    on<InitializeMap>(_initializeMap);
    on<LoadMarkers>(_loadMarkers);
  }

  FutureOr<void> _initializeMap(event, emit) async {
    Position currentLocation = const Position(
        latitude: -34.9187523,
        longitude: -57.9599422,
        isMocked: true,
        accuracy: 1,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        floor: null,
        timestamp: null);
    final newState = HomeDone();
    newState.homeUiModel =
        newState.homeUiModel.copyWith(currentLocation: currentLocation);
    emit(newState);
  }

  FutureOr<void> _loadMarkers(event, emit) async {
    print("cargando animalMarker");
    var animalMarkerList = <AnimalMarker>[
    AnimalMarker("place_name0", -34.9194897, -57.9564453, "Perrito", "Perdido",
        "assets/markers/icon_perdido.png"),
    AnimalMarker("place_name1", -34.9215817, -57.9528336, "Gatito", "Perdido",
        "assets/markers/icon_perdido.png"),
    AnimalMarker("place_name2", -34.920117, -57.9575637, "Gatito", "En tránsito",
        "assets/markers/icon_transito.png"),
    AnimalMarker("place_name3", -34.9222768, -57.9554499, "Rescataditos LP", "Refugio",
        "assets/markers/icon_refugio.png"),
    ];
    final newState = HomeDone();
    newState.homeUiModel = (state as HomeDone).homeUiModel.copyWith(animalMarkerList: animalMarkerList);
    emit(newState);
  }
}
