import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/presentation/extension/extension.dart';
import '../../../../core/presentation/widget/widget.dart';
import '../../domain/model/cinema_model.dart';

class SelectedCinemaWidget extends StatelessWidget {
  final void Function() onBackPressed;
  final CinemaModel cinema;
  final String distance, duration;

  const SelectedCinemaWidget({
    super.key,
    required this.cinema,
    required this.distance,
    required this.duration,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                Row(
                  children: [
                    IconButton(
                      onPressed: onBackPressed,
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    Text(
                      cinema.name,
                      style: context.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(4),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    ChipAttribute(distance),
                    ChipAttribute(duration),
                  ],
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
        ],
      ),
    );
  }
}

class CinemaWidgetLoading extends StatelessWidget {
  const CinemaWidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
      child: const LoadingWidget(),
    );
  }
}
