import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../config/di/injection.dart';
import '../../../../core/core.dart';
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
  ReminderModel? _reminderModel;

  @override
  void initState() {
    _getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return BlocConsumer<ReminderCubit, ReminderState>(
      listener: (context, state) {
        _onStateChanged(state);
      },
      builder: (context, state) {
        if (state is GetReminderLoaded || state is SaveReminderLoaded) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              _baseRow(
                title: 'Enabled',
                trailing: Switch.adaptive(
                  value: _reminderModel?.enabled ?? false,
                  onChanged: _onSwitchChanged,
                ),
              ),
              const Gap(8),
              _baseRow(
                title: 'Date',
                trailing: _baseButton(
                  onPressed: _showDatePicker,
                  title: _reminderModel?.time != null
                      ? _reminderModel!.time.formatDate()
                      : 'Select Date',
                ),
              ),
              const Gap(8),
              _baseRow(
                title: 'Time',
                trailing: _baseButton(
                  onPressed: _showTimePicker,
                  title: _reminderModel?.time != null
                      ? _reminderModel!.time.formatDate(outputType: 'HH:mm')
                      : 'Select Time',
                ),
              ),
            ],
          );
        }

        return const LoadingWidget();
      },
    );
  }

  Widget _baseButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: _reminderModel?.enabled == true ? onPressed : null,
      child: Text(title),
    );
  }

  Widget _baseRow({
    required String title,
    required Widget trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.titleMedium,
        ),
        trailing,
      ],
    );
  }

  void _onSwitchChanged(bool value) {
    _saveChanges(
      _reminderModel?.copyWith(enabled: value) ??
          emptyReminder.copyWith(enabled: value),
    );
  }

  void _saveChanges(ReminderModel reminder) {
    context.read<ReminderCubit>().saveReminder(reminder);
  }

  void _getInitialData() {
    context.read<ReminderCubit>()
      ..initNotification()
      ..getReminder();
  }

  void _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      _saveChanges(
        _reminderModel!.copyWith(time: date),
      );
    }
  }

  void _showTimePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      final newDate = _reminderModel!.time.applied(time);
      _saveChanges(_reminderModel?.copyWith(time: newDate) ??
          emptyReminder.copyWith(time: newDate));
    }
  }

  void _onStateChanged(ReminderState state) {
    if (state is SaveReminderLoaded) {
      _reminderModel = state.reminder;
      context.showSnackBar(message: 'Reminder saved');
    } else if (state is GetReminderError) {
      context.showSnackBar(message: state.message);
    } else if (state is SaveReminderError) {
      context.showSnackBar(message: state.message);
    } else if (state is GetReminderLoaded) {
      _reminderModel = state.reminder;
    }
  }
}
