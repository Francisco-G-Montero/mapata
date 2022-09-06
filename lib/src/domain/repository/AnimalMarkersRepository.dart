import '../../data/model/AnimalMarker.dart';
import '../../data/util/NetResult.dart';

abstract class AnimalMarkersRepository {
  Future<DataResult<List<AnimalMarker>>> getAnimalMarkers();
}