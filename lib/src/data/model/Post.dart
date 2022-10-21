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
  DateTime date;
  String imageUrl;
  String title;
  String description;
  String age;
  String gender;
  String postStatus;
  String postOwnerId;
  String? transitanteId;
  String? adopterId;

  Post(
      {this.id = "",
      required this.date,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.age,
      required this.gender,
      required this.postStatus,
      required this.postOwnerId,
      required this.transitanteId,
      required this.adopterId});

  @override
  List<Object?> get props => [id, date, imageUrl, title, description, age, gender, postStatus, postOwnerId, transitanteId, adopterId];

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);

  Map<String, Object?> toJson() => _$PostToJson(this);

  static Post getBlankPost() {
    return Post(
      id: "",
      date: DateTime.now(),
      imageUrl: "",
      title: "",
      description: "",
      age: "",
      gender: "",
      postStatus: "",
      postOwnerId: "",
      transitanteId: "",
      adopterId: "",
    );
  }
}
