import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class HomeUiModel extends Equatable{
  final Position? currentLocation;
  const HomeUiModel({this.currentLocation,});

  @override
  List<Object?> get props => [currentLocation];

  HomeUiModel copyWith({
    Position? currentLocation,
  }) {
    return HomeUiModel(
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}