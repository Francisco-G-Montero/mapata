import 'dart:async';

import 'package:mapata/src/domain/repository/AnimalMarkersRepository.dart';

import '../../../data/model/AnimalMarker.dart';
import '../../../data/util/NetResult.dart';

class GetAnimalMarkersUseCase2 {
  final AnimalMarkersRepository _animalMarkersRepository;

  GetAnimalMarkersUseCase2(this._animalMarkersRepository);

  StreamController call() {
    return _animalMarkersRepository.getAnimalMarkers2();
  }
}