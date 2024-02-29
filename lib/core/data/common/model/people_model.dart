import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people_model.g.dart';

@JsonSerializable()
class PeopleModel extends Equatable {
  final String name;
  final String height;
  final String mass;
  @JsonKey(name: 'hair_color')
  final String hairColor;
  @JsonKey(name: 'skin_color')
  final String skinColor;
  @JsonKey(name: 'eye_color')
  final String eyeColor;
  @JsonKey(name: 'birth_year')
  final String birthYear;
  final String gender;
  final String homeworld;
  final String created;
  final String edited;
  final String url;

  const PeopleModel({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleModelFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        height,
        mass,
        hairColor,
        skinColor,
        eyeColor,
        birthYear,
        gender,
        homeworld,
        created,
        edited,
        url,
      ];
}
