import 'package:mapata/src/data/model/AnimalMarker.dart';
import 'package:mapata/src/data/util/NetResult.dart';
import '../../domain/repository/AnimalMarkersRepository.dart';
import '../datasource/remote/RealtimeDatabaseService.dart';

class AnimalMarkersRepositoryImpl implements AnimalMarkersRepository {
  final RealtimeDatabaseService _realtimeDatabaseService;

  AnimalMarkersRepositoryImpl(this._realtimeDatabaseService);

  @override
  Future<DataResult<List<AnimalMarker>>> getAnimalMarkers() async {
    final animalMarkerList = _realtimeDatabaseService
        .getAnimalMarkers()
        .then((value) => DataResult.success(value))
        .onError((error, stackTrace) {
      print(error.toString()); //TODO MEJORAR
      return DataResult.failure(GenericFailure());
    });
    return animalMarkerList;
  }
}
