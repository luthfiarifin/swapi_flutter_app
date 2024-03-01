import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/core.dart';
import '../../domain/model/cinema_model.dart';

const double _height = 120;

typedef OnPageChanged = void Function(CinemaModel model);
typedef OnDirectionPressed = void Function(CinemaModel model);

class CinemaList extends StatelessWidget {
  final List<CinemaModel> data;
  final OnPageChanged onPageChanged;
  final OnDirectionPressed onDirectionPressed;

  const CinemaList({
    super.key,
    required this.onPageChanged,
    required this.data,
    required this.onDirectionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        padEnds: false,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: CinemaItem(
              cinema: data[index],
              onDirectionPressed: onDirectionPressed,
            ),
          );
        },
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          onPageChanged(data[value]);
        },
      ),
    );
  }
}

class CinemaItem extends StatelessWidget {
  final CinemaModel cinema;
  final OnDirectionPressed onDirectionPressed;

  const CinemaItem({
    super.key,
    required this.cinema,
    required this.onDirectionPressed,
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
      child: Row(
        children: [
          Flexible(
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
          ),
          const Gap(8),
          IconButton(
            iconSize: 24,
            icon: Icon(
              Icons.directions,
              color: context.colorScheme.primary,
            ),
            onPressed: () => onDirectionPressed(cinema),
          ),
        ],
      ),
    );
  }
}
