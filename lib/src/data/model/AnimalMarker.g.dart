// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnimalMarker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalMarker _$AnimalMarkerFromJson(Map<String, dynamic> json) => AnimalMarker(
      id: json['id'] as String? ?? "",
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      postId: json['postId'] as String,
    );

Map<String, dynamic> _$AnimalMarkerToJson(AnimalMarker instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'postId': instance.postId,
    };
