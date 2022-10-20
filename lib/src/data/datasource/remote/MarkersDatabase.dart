import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:mapata/src/data/datasource/services/RealtimeDatabaseService.dart';

import '../../model/AnimalMarker.dart';
import '../../util/NetResult.dart';

class MarkersDatabase {
  final RealtimeDatabaseService databaseService;

  MarkersDatabase(this.databaseService);

  StreamController getRealtimeAnimalMarkers() {
    final streamController = StreamController<List<AnimalMarker>>();
    var animalMarkerList = <AnimalMarker>[];
    databaseService.getMarkersReference().onChildAdded.listen((event) {
      final data = event.snapshot.value;
      final dataValue = new Map<String, dynamic>.from(data as Map);
      final animalMarker = AnimalMarker.fromJson(dataValue);
      animalMarker.id = data.keys.first!;
      animalMarkerList.add(animalMarker);
      streamController.sink.add(animalMarkerList);
    });
    databaseService.getMarkersReference().onChildChanged.listen((event) {
      final data = event.snapshot.value;
      final dataValue = new Map<String, dynamic>.from(data as Map);
      final animalMarker = AnimalMarker.fromJson(dataValue);
      animalMarker.id = data.keys.first!;
      animalMarkerList.removeWhere((element) => element.id == animalMarker.id);
      animalMarkerList.add(animalMarker);
      streamController.sink.add(animalMarkerList);
    });
    return streamController;
  }

  Future<List<AnimalMarker>> getAnimalMarkers() async {
    var animalMarkerList = <AnimalMarker>[];
    await databaseService.getMarkersReference().get().then((snapshot) {
      if (snapshot.exists) {
        snapshot.children.forEach((element) {
          if (element != null) {
            final dataValue = new Map<String, dynamic>.from(element.value as Map);
            final animalMarker = AnimalMarker.fromJson(dataValue);
            animalMarker.id = element.key!;
            animalMarkerList.add(animalMarker);
          }
        });
      }
    });
    return animalMarkerList;
  }

  Future<DataResult<String>> createMarker(AnimalMarker animalMarker) async {
    DatabaseReference newMarkerRef = await databaseService.getMarkersReference().push();
    try {
      await databaseService.getMarkerReference(newMarkerRef.key!).set(animalMarker.toJson());
      return DataResult.success(newMarkerRef.key!);
    } catch (error) {
      return DataResult.failure(GenericFailure());
    }
  }

  Future<DataResult<AnimalMarker>> getMarkerById(String markerId) async {
    AnimalMarker? marker;
    await databaseService.getMarkerReference(markerId).get().then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.value != null) {
          final dataValue = new Map<String, dynamic>.from(snapshot.value as Map);
          marker = AnimalMarker.fromJson(dataValue);
          marker!.id = snapshot.key!;
        }
      }
    });
    return marker != null ? DataResult.success(marker!) : DataResult.failure(GenericFailure());
  }

  Future<DataResult<void>> deleteMarkerById(String markerId) async {
    try {
      await databaseService.getMarkerReference(markerId).remove();
      return DataResult.success(null);
    } catch (e) {
      return DataResult.failure(GenericFailure());
    }
  }

  Future<DataResult<void>> updateMarker(AnimalMarker marker) async {
    try {
      await databaseService.getMarkerReference(marker.id).update(marker.toJson());
      return DataResult.success(null);
    } catch (e) {
      return DataResult.failure(GenericFailure());
    }
  }
}
