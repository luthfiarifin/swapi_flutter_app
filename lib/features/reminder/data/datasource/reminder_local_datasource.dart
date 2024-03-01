import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../../core/data/error/exceptions.dart';
import '../../../../core/data/local/shared_preference.dart';
import '../../domain/model/model.dart';

abstract class ReminderLocalDataSource {
  Future<ReminderModel?> getReminder();
  Future<ReminderModel> saveReminder(ReminderModel reminder);
}

@Injectable(as: ReminderLocalDataSource)
class ReminderLocalDataSourceImpl implements ReminderLocalDataSource {
  final String _reminderKey = 'reminder';

  @override
  Future<ReminderModel?> getReminder() async {
    final value = await SharedPreference.getString(_reminderKey);

    if (value != null) {
      return ReminderModel.fromJson(json.decode(value));
    } else {
      return null;
    }
  }

  @override
  Future<ReminderModel> saveReminder(ReminderModel reminder) async {
    await SharedPreference.saveData(
      _reminderKey,
      json.encode(reminder.toJson()),
    );

    final ReminderModel? data = await getReminder();

    if (data == null) {
      throw const LocalException(message: 'Failed to save reminder');
    } else {
      return data;
    }
  }
}
