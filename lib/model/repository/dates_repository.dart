import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRepository {
  static Future<DateTime> selectDate(
      {required BuildContext context, DateTime? initial}) async {
    DateTime now = DateTime.now();
    initial = initial ?? now;

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime(now.year, 1),
        lastDate: DateTime(now.year, 12));
    return picked ?? initial;
  }

  static Future<TimeOfDay> selectTime(
      {required BuildContext context, TimeOfDay? initial}) async {
    TimeOfDay now = TimeOfDay.now();
    initial = initial ?? now;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    return picked ?? initial;
  }
}

extension Formating on DateTime {
  String get formatDate => DateFormat('dd-MM-yyyy').format(this);
}

extension Parsing on String {
  DateTime get parseDate => DateFormat('dd-MM-yyyy').parse(this);
  TimeOfDay get parseTime =>
      TimeOfDay.fromDateTime(DateFormat.jm().parse(this));
}
