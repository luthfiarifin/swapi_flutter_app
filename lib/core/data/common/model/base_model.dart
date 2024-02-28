import 'package:equatable/equatable.dart';

class BaseModel<T> extends Equatable {
  final String? next;
  final String? previous;
  final List<T> results;

  const BaseModel({
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json, Function fromJsonT) {
    return BaseModel(
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map<T>((post) => fromJsonT(post))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson(List<dynamic> post) {
    return {
      'next': next,
      'previous': previous,
      'results': results,
    };
  }

  @override
  List<Object?> get props => [
        next,
        previous,
        results,
      ];
}
