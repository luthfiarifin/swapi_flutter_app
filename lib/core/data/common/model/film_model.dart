import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'film_model.g.dart';

@JsonSerializable()
class FilmModel extends Equatable {
  final String title;
  @JsonKey(name: 'episode_id')
  final int episodeId;
  @JsonKey(name: 'opening_crawl')
  final String openingCrawl;
  final String director;
  final String producer;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final List<String> characters;
  final String created;
  final String edited;

  const FilmModel({
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.characters,
    required this.created,
    required this.edited,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) =>
      _$FilmModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilmModelToJson(this);

  @override
  List<Object?> get props => [
        title,
        episodeId,
        openingCrawl,
        director,
        producer,
        releaseDate,
        characters,
        created,
        edited,
      ];
}
