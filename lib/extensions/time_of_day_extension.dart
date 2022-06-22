import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String getTime() {
    String time;
    String hours = (hour >= 12 ? (hour - 12) : hour).toString();
    hours = hours.length == 1 ? ('0' + hours) : hours;
    String minutes = minute.toString().length == 1 ? ('0' + minute.toString()) : minute.toString();
    time = hours + ':' + minutes + ' ' + period.name;
    return time;
  }
}
