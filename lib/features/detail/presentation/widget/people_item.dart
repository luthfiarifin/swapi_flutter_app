import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/data/common/model/people_model.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../../../core/presentation/widget/widget.dart';

const double _width = 200;

class PeopleItem extends StatelessWidget {
  final PeopleModel people;

  const PeopleItem({
    super.key,
    required this.people,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colorScheme.onBackground.withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            people.name,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
              ChipAttribute(
                people.gender[0].toUpperCase() + people.gender.substring(1),
              ),
              ChipAttribute(people.birthYear),
            ],
          ),
        ],
      ),
    );
  }
}

class PeopleItemShimmer extends StatelessWidget {
  const PeopleItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colorScheme.onBackground.withOpacity(0.1),
        ),
      ),
      width: _width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShimmerWidget(
            radius: 16,
            height: 16,
          ),
          Gap(40),
          Row(
            children: [
              ShimmerWidget(
                radius: 16,
                width: 32,
                height: 16,
              ),
              Gap(4),
              ShimmerWidget(
                radius: 16,
                width: 32,
                height: 16,
              ),
            ],
          )
        ],
      ),
    );
  }
}
