import 'dart:async';

import 'package:mapata/src/data/datasource/remote/MarkersDatabase.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';
import 'package:mapata/src/data/util/NetResult.dart';
import '../../domain/repository/AnimalMarkersRepository.dart';

class AnimalMarkersRepositoryImpl implements AnimalMarkersRepository {
  final MarkersDatabase _markersDatabase;

  AnimalMarkersRepositoryImpl(this._markersDatabase);

  @override
  Future<DataResult<List<AnimalMarker>>> getAnimalMarkers() async {
    final animalMarkerList = _markersDatabase
        .getAnimalMarkers()
        .then((value) => DataResult.success(value))
        .onError((error, stackTrace) {
      print(error.toString()); //TODO MEJORAR
      return DataResult.failure(GenericFailure());
    });
    return animalMarkerList;
  }

  @override
  StreamController getRealtimeAnimalMarkers() {
    return _markersDatabase.getRealtimeAnimalMarkers();
  }

  @override
  Future<DataResult<void>> createAnimalMarker(AnimalMarker animalMarker) {
    // TODO: implement createAnimalMarker
    throw UnimplementedError();
  }
}
