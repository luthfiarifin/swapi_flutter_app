import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/data/common/model/people_model.dart';
import 'people_item.dart';

class PeopleList extends StatelessWidget {
  final List<PeopleModel>? people;

  const PeopleList({
    super.key,
    required this.people,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 120;

    if (people != null) {
      return SizedBox(
        height: height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) => PeopleItem(people: people![i]),
          separatorBuilder: (context, index) => const Gap(8),
          itemCount: people!.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => const PeopleItemShimmer(),
        separatorBuilder: (_, __) => const Gap(8),
        itemCount: 5,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
