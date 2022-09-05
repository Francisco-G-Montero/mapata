import 'package:equatable/equatable.dart';

class AnimalMarker extends Equatable{
  final String id;
  final double lat;
  final double lng;
  final String title;
  final String description;
  final String imageUrl;


  const AnimalMarker(this.id, this.lat, this.lng, this.title, this.description, this.imageUrl);

  @override
  List<Object?> get props => [];
}