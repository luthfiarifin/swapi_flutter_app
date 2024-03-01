import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/core.dart';
import '../../domain/model/cinema_model.dart';

const double _height = 120;

class CinemaList extends StatelessWidget {
  final void Function(CinemaModel model) onPageChanged;

  const CinemaList({
    super.key,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    const cinemas = cinemaList;

    return SizedBox(
      height: _height,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        padEnds: false,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: CinemaItem(
              cinema: cinemas[index],
            ),
          );
        },
        itemCount: cinemas.length,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          onPageChanged(cinemas[value]);
        },
      ),
    );
  }
}

class CinemaItem extends StatelessWidget {
  final CinemaModel cinema;

  const CinemaItem({
    super.key,
    required this.cinema,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.7,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cinema.name,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8),
          Text(
            cinema.address,
            style: context.labelMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
