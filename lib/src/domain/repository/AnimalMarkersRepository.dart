import 'dart:async';

import '../../data/model/AnimalMarker.dart';
import '../../data/util/NetResult.dart';

abstract class AnimalMarkersRepository {
  Future<DataResult<List<AnimalMarker>>> getAnimalMarkers();
  StreamController getRealtimeAnimalMarkers();
  Future<DataResult<void>> createAnimalMarker(AnimalMarker animalMarker);
  Future<DataResult<void>> deleteAnimalMarker(String markerId);
  Future<DataResult<void>> updateAnimalMarker(AnimalMarker animalMarker);
}