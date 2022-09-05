import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapata/src/data/model/AnimalMarker.dart';

class HomeUiModel extends Equatable{
  final Position? currentLocation;
  final List<AnimalMarker> animalMarkerList;

  const HomeUiModel({this.currentLocation, this.animalMarkerList = const []});

  @override
  List<Object?> get props => [currentLocation, animalMarkerList];

  HomeUiModel copyWith({
    Position? currentLocation,
    List<AnimalMarker>? animalMarkerList,
  }) {
    return HomeUiModel(
      currentLocation: currentLocation ?? this.currentLocation,
      animalMarkerList: animalMarkerList ?? this.animalMarkerList,
    );
  }
}