import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension XDateExtension on DateTime {
  String formatDate({
    String outputType = 'MMM dd, yyyy',
    bool isLocalTimeZone = true,
  }) {
    var inputDate = isLocalTimeZone ? toLocal() : this;

    var outputFormat = DateFormat(outputType);
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
