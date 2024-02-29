import 'package:equatable/equatable.dart';

class GetPeopleParam extends Equatable {
  final List<int> ids;

  const GetPeopleParam({
    required this.ids,
  });

  @override
  List<Object?> get props => [
        ids,
      ];
}
