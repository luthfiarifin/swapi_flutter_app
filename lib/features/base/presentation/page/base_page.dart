import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/router/app_router.dart';
import '../../../../core/presentation/extension/extension.dart';

@RoutePage()
class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        CinemaRoute(),
        ReminderRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: _appBar(),
          body: child,
          bottomNavigationBar: _bottomNavBar(tabsRouter),
        );
      },
    );
  }

  Widget _bottomNavBar(TabsRouter tabsRouter) {
    return BottomNavigationBar(
      currentIndex: tabsRouter.activeIndex,
      onTap: (index) {
        tabsRouter.setActiveIndex(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          label: 'Cinema',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alarm),
          label: 'Reminder',
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'SwapiApp',
        style: context.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leadingWidth: 40,
      automaticallyImplyLeading: false,
      actions: [
        _notificationIcon(),
      ],
      leading: _profileAvatar(),
    );
  }

  Widget _notificationIcon() {
    return Container(
      height: 26,
      width: 26,
      margin: const EdgeInsets.only(right: 16),
      child: SvgPicture.asset(
        'assets/icon/notification.svg',
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _profileAvatar() {
    return Transform.translate(
      offset: const Offset(16, 0),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          'assets/avatar/profile.svg',
          height: 32,
          width: 32,
        ),
      ),
    );
  }
}
