import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../config/di/injection.dart';
import '../../../../config/router/router.dart';
import '../../../../core/data/common/model/film_model.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../../../core/presentation/widget/widget.dart';
import '../constant/banner_constant.dart';
import '../cubit/cubit.dart';
import '../widget/widget.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  final _pagingController = PagingController<int, FilmModel>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _listenPaging();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          _onStateChanged(state);
        },
        child: _body(),
      ),
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

  Widget _body() {
    return CustomScrollView(
      slivers: [
        MultiSliver(
          children: [
            const Gap(16),
            _banners(),
            const Gap(24),
            _filmTitle(),
            const Gap(16),
            _pagedList(),
            const Gap(48),
          ],
        ),
      ],
    );
  }

  Widget _banners() {
    return HomeBannerCarousel(
      urls: BannerConstant.bannerList,
      onTap: _onBannerClicked,
    );
  }

  void _onBannerClicked(String url) {}

  Widget _filmTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Star Wars Films',
        style: context.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _pagedList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: PagedSliverList<int, FilmModel>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) {
            return FilmItem(
              film: item,
              onTap: _navigateToDetail,
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return _loadingIndicator();
          },
          firstPageProgressIndicatorBuilder: (context) {
            return _loadingIndicator();
          },
        ),
        separatorBuilder: (context, index) => const Gap(16),
      ),
    );
  }

  void _navigateToDetail(FilmModel film) {
    context.router.push(DetailRoute(
      id: film.url.getId() ?? 0,
      title: film.title,
    ));
  }

  Widget _loadingIndicator() {
    return const LoadingWidget();
  }

  void _onStateChanged(HomeState state) {
    if (state is GetFilmsLoaded) {
      _appendPaging(state);
    } else if (state is GetFilmsError) {
      _pagingController.error = state.message;
      _showSnackbar(state.message);
    }
  }

  void _appendPaging(GetFilmsLoaded state) {
    var nextUri = Uri.tryParse(state.response.next ?? '');
    final int? nextPageKey =
        int.tryParse(nextUri?.queryParameters['page'] ?? '');

    if (nextPageKey == null) {
      _pagingController.appendLastPage(state.response.results);
    } else {
      _pagingController.appendPage(state.response.results, nextPageKey);
    }
  }

  void _showSnackbar(String message) {
    context.showSnackBar(message: message);
  }

  void _listenPaging() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<HomeCubit>().getFilms(pageKey);
    });
  }
}
