import 'package:firebase_database/firebase_database.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';

class RealtimeDatabaseService {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  DatabaseReference _getMarkersReference() {
    return FirebaseDatabase.instance.ref('markers');
  }

  Future<List<AnimalMarker>> getAnimalMarkers() async {
    var animalMarkerList = <AnimalMarker>[];
    await _getMarkersReference()
        .get()
        .then((snapshot) {
          if(snapshot.exists){
            snapshot.children.forEach((element) {
              if(element != null){
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
}