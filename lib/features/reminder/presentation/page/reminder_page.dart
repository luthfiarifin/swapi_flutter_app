import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/injection.dart';
import '../cubit/reminder_cubit.dart';

@RoutePage()
class ReminderPage extends StatefulWidget implements AutoRouteWrapper {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReminderCubit>(),
      child: this,
    );
  }
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
