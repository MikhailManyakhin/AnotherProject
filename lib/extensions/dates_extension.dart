Map<int, String> monthNames = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec'
};

Map<int, String> weekdaysNames = {
  1: 'Mo',
  2: 'Tu',
  3: 'We',
  4: 'Th',
  5: 'Fr',
  6: 'Sa',
  7: 'Su'
};

extension DatesExtension on DateTime {
  String getMonthName() {
    return monthNames[month]??'';
  }

  String getWeekdayName() {
    return weekdaysNames[weekday]??'';
  }

  int numberOfDaysInMonth() {
    switch (month) {
      case 0:
      case 3:
      case 5:
      case 7:
      case 11:
        return 31;
      case 2:
        return year % 4 == 0 ? 29 : 28;
      default:
        return 30;
    }
  }
}
