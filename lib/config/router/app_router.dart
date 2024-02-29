import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/features.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: BaseRoute.page,
          initial: true,
          path: '/',
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: 'home',
            ),
            AutoRoute(
              page: CinemaRoute.page,
              path: 'cinema',
            ),
          ],
        ),
        AutoRoute(
          page: DetailRoute.page,
          path: '/film/:id',
        ),
      ];
}
