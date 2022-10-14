// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String? ?? "",
      date: DateTime.parse(json['date'] as String),
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      postOwnerId: json['postOwnerId'] as String,
      transitanteId: json['transitanteId'] as String,
      adopterId: json['adopterId'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'description': instance.description,
      'postOwnerId': instance.postOwnerId,
      'transitanteId': instance.transitanteId,
      'adopterId': instance.adopterId,
    };
