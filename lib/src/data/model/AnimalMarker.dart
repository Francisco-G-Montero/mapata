import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'AnimalMarker.g.dart';

@JsonSerializable(explicitToJson: true)
class AnimalMarker extends Equatable{
  String id;
  final double lat;
  final double lng;
  final String title;
  final String description;
  final String imageUrl;

  AnimalMarker({this.id = "", required this.lat, required this.lng, required this.title, required this.description, required this.imageUrl});

  @override
  List<Object?> get props => [];

  factory AnimalMarker.fromJson(Map<String, Object?> json) => _$AnimalMarkerFromJson(json);

  //se mejoro la serializacion para manejar el id (remover) del document
  Map<String, Object?> toJson() => _$AnimalMarkerToJson(this);

}