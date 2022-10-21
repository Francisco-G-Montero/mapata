import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';
import 'package:mapata/src/presentation/blocs/home/HomeEvent.dart';
import 'package:mapata/src/presentation/blocs/home/HomeState.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapata/src/presentation/blocs/home/HomeUiModel.dart';

import '../../../data/util/NetResult.dart';
import '../../../domain/usecases/remote/GetAnimalMarkersUseCase.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAnimalMarkersUseCase _getAnimalMarkersUseCase;

  HomeBloc(this._getAnimalMarkersUseCase) : super(const HomeLoading()) {
    on<InitializeMap>(_initializeMap);
    on<LoadMarkers>(_loadMarkers);
    on<ReloadMarkers>(_reloadMarkers);
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
    final newState = HomeDone(streamController: null);
    newState.homeUiModel =
        newState.homeUiModel.copyWith(currentLocation: currentLocation);
    emit(newState);
  }

  FutureOr<void> _loadMarkers(event, emit) async {
    final dataResult = await _getAnimalMarkersUseCase.getAnimalMarkers();
    dataResult.either((error) {
      return GenericFailure();
    }, (animalMarkerList) {
      final newState = HomeDone(streamController: _getAnimalMarkersUseCase.getRealtimeAnimalMarkers());
      newState.homeUiModel = (state as HomeDone).homeUiModel.copyWith(animalMarkerList: animalMarkerList);
      emit(newState);
    });
  }

  FutureOr<void> _reloadMarkers(event, emit) async {
    final dataResult = await _getAnimalMarkersUseCase.getAnimalMarkers();
    dataResult.either((error) {
      return GenericFailure();
    }, (animalMarkerList) {
      final newState = HomeDone(streamController: (state as HomeDone).streamController);
      newState.homeUiModel = (state as HomeDone).homeUiModel.copyWith(animalMarkerList: animalMarkerList);
      emit(newState);
    });
  }
}
