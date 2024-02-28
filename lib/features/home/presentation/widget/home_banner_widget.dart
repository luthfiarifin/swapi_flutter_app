import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../../../../core/presentation/extension/build_context_extension.dart';
import '../../../../core/presentation/widget/image_network.dart';

typedef OnTapHomeBanner = void Function(String);

class HomeBannerCarousel extends StatelessWidget {
  final List<String> urls;
  final OnTapHomeBanner onTap;

  const HomeBannerCarousel({
    super.key,
    required this.urls,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: urls.length,
      itemBuilder: (_, index, __) {
        return HomeBanner(
          url: urls[index],
          onTap: onTap,
        );
      },
      options: _carouselOptions(),
    );
  }

  CarouselOptions _carouselOptions({
    bool autoPlay = true,
  }) {
    return CarouselOptions(
      aspectRatio: 16 / 9,
      autoPlay: autoPlay,
      autoPlayInterval: const Duration(seconds: 5),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      slideIndicator: CircularSlideIndicator(
        padding: const EdgeInsets.only(bottom: 16),
        currentIndicatorColor: Colors.white,
        indicatorBackgroundColor: Colors.white.withOpacity(0.8),
        indicatorBorderColor: Colors.grey.shade800,
        indicatorRadius: 3,
        itemSpacing: 10,
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
    required this.url,
    required this.onTap,
  });

  final OnTapHomeBanner onTap;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(url),
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ImageNetwork(
          url,
          fit: BoxFit.cover,
          height: context.height,
        ),
      ),
    );
  }
}
