import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post extends Equatable {
  String id;
  final DateTime date;
  final String imageUrl;
  final String title;
  final String description;
  final String postOwnerId;
  final String transitanteId;
  final String adopterId;

  Post(
      {this.id = "",
      required this.date,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.postOwnerId,
      required this.transitanteId,
      required this.adopterId});

  @override
  List<Object?> get props => [id, date, imageUrl, title, description, postOwnerId, transitanteId, adopterId];

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);

  Map<String, Object?> toJson() => _$PostToJson(this);
}
