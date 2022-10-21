import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AnimalMarker.g.dart';

@JsonSerializable(explicitToJson: true)
class AnimalMarker extends Equatable {
  String id;
  final double lat;
  final double lng;
  String title;
  String description;
  final String imageUrl;
  final String postId;

  AnimalMarker(
      {this.id = "",
      required this.lat,
      required this.lng,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.postId});

  @override
  List<Object?> get props => [id, lat, lng, title, description, imageUrl, postId];

  factory AnimalMarker.fromJson(Map<String, Object?> json) => _$AnimalMarkerFromJson(json);

  //se mejoro la serializacion para manejar el id (remover) del document
  Map<String, Object?> toJson() => _$AnimalMarkerToJson(this);
}
