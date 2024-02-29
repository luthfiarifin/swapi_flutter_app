import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../config/di/injection.dart';
import '../../../../core/data/common/model/model.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../../../core/presentation/widget/widget.dart';
import '../cubit/detail_cubit.dart';
import '../widget/widget.dart';

@RoutePage()
class DetailPage extends StatefulWidget implements AutoRouteWrapper {
  final int id;
  final String? title;

  const DetailPage({
    @PathParam('id') required this.id,
    @QueryParam('title') this.title,
    super.key,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DetailCubit>(),
      child: this,
    );
  }
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    _getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar();
  }

  Widget _body() {
    return BlocConsumer<DetailCubit, DetailState>(
      listener: (context, state) {
        _onStateChange(state);
      },
      builder: (context, state) {
        final filmModel = context.read<DetailCubit>().filmModel;

        return ListView(
          children: [
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Hero(
                tag: widget.id,
                child: Text(
                  widget.title ?? filmModel?.title ?? '',
                  style: context.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Gap(24),
            if (filmModel == null) const LoadingWidget(),
            if (filmModel != null) ..._filmItems(filmModel, state)
          ],
        );
      },
    );
  }

  List<Widget> _filmItems(
    FilmModel filmModel,
    DetailState state,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ChipAttribute(filmModel.releaseDate.formatDate()),
            ChipAttribute('Director: ${filmModel.director}'),
            ChipAttribute('Producer: ${filmModel.producer}'),
            ChipAttribute('Episode: ${filmModel.episodeId}'),
          ],
        ),
      ),
      const Gap(24),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          filmModel.openingCrawl.replaceAll('\n', ''),
        ),
      ),
      const Gap(32),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Characters',
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const Gap(8),
      PeopleList(
        people: state is GetPeopleLoaded ? state.people : null,
      ),
    ];
  }

  void _getInitialData() {
    context.read<DetailCubit>().getFilm(widget.id);
  }

  void _onStateChange(DetailState state) {
    if (state is GetFilmError) {
      _showErrorMessage(state.message);
    } else if (state is GetPeopleError) {
      _showErrorMessage(state.message);
    }
  }

  void _showErrorMessage(String message) {
    context.showSnackBar(message: message);
  }
}
