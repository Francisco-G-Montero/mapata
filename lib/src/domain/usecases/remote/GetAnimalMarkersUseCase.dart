import 'package:mapata/src/domain/repository/AnimalMarkersRepository.dart';

import '../../../data/model/AnimalMarker.dart';
import '../../../data/util/NetResult.dart';

class GetAnimalMarkersUseCase {
  final AnimalMarkersRepository _animalMarkersRepository;

  GetAnimalMarkersUseCase(this._animalMarkersRepository);

  Future<DataResult<List<AnimalMarker>>> call() async {
    var champions = await _animalMarkersRepository.getAnimalMarkers();
    return champions;
  }
}