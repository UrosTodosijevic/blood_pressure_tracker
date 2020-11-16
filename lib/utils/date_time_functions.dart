import 'package:flutter/material.dart';

/// Da ne bih kasnije imao problema sa sekundama/milisekundama
DateTime currentDateTime() {
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  );
}

DateTime makeNewDateTime(DateTime date, TimeOfDay time) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

/// Funkcije za odredjivanje prvog i poslednjeg dana u nedelji kojoj
/// pripada prosledjeni datum
DateTime firstDayOfTheWeek(DateTime date) {
  final startDate = date.subtract(Duration(days: date.weekday - 1));
  final startDateWithTime =
      DateTime(startDate.year, startDate.month, startDate.day);
  return startDateWithTime;
}

DateTime lastDayOfTheWeek(DateTime date) {
  final endDate = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  final endDateWithTime =
      DateTime(endDate.year, endDate.month, endDate.day, 23, 59);
  return endDateWithTime;
}

/// Funkcije za odredjivanje prvog i poslednjeg dana u mesecu kojem
/// pripada prosledjeni datum
DateTime firstDayOfTheMonth(DateTime date) {
  if (date != null) {
    return DateTime(date.year, date.month, 1);
  }
  return null;
}

DateTime lastDayOfTheMonth(DateTime date) {
  if (date != null) {
    final numberOfDaysInMonth = _getNumberOfDaysInMonth(date);
    return DateTime(date.year, date.month, numberOfDaysInMonth, 23, 59);
  }
  return null;
}

int _getNumberOfDaysInMonth(DateTime date) {
  if (date != null) {
    DateTime firstDayOfNextMonth;
    if (date.month < 12) {
      firstDayOfNextMonth = DateTime(date.year, date.month + 1, 1);
    } else {
      firstDayOfNextMonth = DateTime(date.year + 1, 1, 1);
    }
    DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(Duration(days: 1));
    return lastDayOfCurrentMonth.day;
  }
  return null;
}

/// Funkcije za pokretanje date i time pickera
Future<DateTime> selectDate(BuildContext context, DateTime initialDate) async {
  final DateTime pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now().subtract(Duration(days: 30)),
    lastDate: DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendar,
  );
  return pickedDate;
}

Future<TimeOfDay> selectTime(
    BuildContext context, TimeOfDay initialTime) async {
  final pickedTime = await showTimePicker(
    initialEntryMode: TimePickerEntryMode.input,
    context: context,
    initialTime: initialTime,
  );
  return pickedTime;
}
