import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Post.g.dart';

enum AnimalGender {
  MALE, FEMALE, UNKNOWN
}

enum AnimalAge {
  YOUNG, OLD, UNKNOWN
}

enum PostStatus {
  LOST, TRANSITANDO
}

@JsonSerializable(explicitToJson: true)
class Post extends Equatable {
  String id;
  final DateTime date;
  final String imageUrl;
  final String title;
  final String description;
  final String age;
  final String gender;
  final String postOwnerId;
  final String? transitanteId;
  final String? adopterId;

  Post(
      {this.id = "",
      required this.date,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.age,
      required this.gender,
      required this.postOwnerId,
      required this.transitanteId,
      required this.adopterId});

  @override
  List<Object?> get props => [id, date, imageUrl, title, description, age, gender, postOwnerId, transitanteId, adopterId];

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);

  Map<String, Object?> toJson() => _$PostToJson(this);
}
