import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/data/common/model/film_model.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../../../core/presentation/widget/widget.dart';

class FilmItem extends StatelessWidget {
  final FilmModel film;
  final Function(FilmModel) onTap;

  const FilmItem({
    super.key,
    required this.film,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(film),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.colorScheme.onBackground.withOpacity(0.1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: film.url.getId() ?? film.title,
              child: Text(
                film.title,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(4),
            Text(
              film.openingCrawl.replaceAll('\n', ''),
              style: context.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(12),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              children: [
                ChipAttribute(film.releaseDate.formatDate()),
                ChipAttribute(film.director),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
