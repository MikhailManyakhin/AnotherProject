import 'package:flutter/material.dart';
import 'package:vedita_learning_project/domain/entity/task.dart';
import 'package:vedita_learning_project/extensions/dates_extension.dart';
import 'package:vedita_learning_project/extensions/time_of_day_extension.dart';

class AddTaskModel {
  DateTime dateTime;
  TimeOfDay timeOfStart;
  TimeOfDay timeOfEnd;
  TaskTypes taskType;
  AddTaskModel(
      {required this.dateTime,
      required this.timeOfStart,
      required this.timeOfEnd,
      required this.taskType});
}

class AddTaskViewModel extends ChangeNotifier {
  final BuildContext _context;
  final _addTaskNameController = TextEditingController();
  final _addTaskDateController = TextEditingController();
  final _selectStartTimeController = TextEditingController();
  final _selectEndTimeController = TextEditingController();
  final _descriptionController = TextEditingController();
  // DateTime _selectedDate = DateTime.now();
  // String _month = '', _day = '', _year = '';
  // TimeOfDay _timeOfStart = TimeOfDay.now();
  // TimeOfDay _timeOfEnd = TimeOfDay.now();
  int _selectedIndex = 0;
  final List<String> _categories = [
    'Design',
    'Meeting',
    'Coding',
    'BDE',
    'Testing',
    'Quick Call'
  ];
  final AddTaskModel _addTaskModel = AddTaskModel(
      dateTime: DateTime.now(),
      timeOfStart: TimeOfDay.now(),
      timeOfEnd: TimeOfDay.now(),
      taskType: TaskTypes.design);

  get addTaskNameController => _addTaskNameController;
  get addTaskDateController => _addTaskDateController;
  get startTimeController => _selectStartTimeController;
  get endTimeController => _selectEndTimeController;
  get descriptionController => _descriptionController;
  get selectedIndex => _selectedIndex;
  get categories => _categories;

  AddTaskViewModel(this._context) {
    final String month = _addTaskModel.dateTime.getMonthName();
    final String year = _addTaskModel.dateTime.year.toString();
    final String day = _addTaskModel.dateTime.day.toString();
    _addTaskDateController.text = '$month $day, $year';
    _selectStartTimeController.text = _addTaskModel.timeOfStart.getTime();
    _selectEndTimeController.text = _addTaskModel.timeOfEnd.getTime();
  }

  onAddDatePressed() async {
    final DateTime? picked = await showDatePicker(
        context: _context,
        initialDate: _addTaskModel.dateTime,
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _addTaskModel.dateTime) {
      _addTaskModel.dateTime = picked;
      final String month = _addTaskModel.dateTime.getMonthName();
      final String year = _addTaskModel.dateTime.year.toString();
      final String day = _addTaskModel.dateTime.day.toString();
      _addTaskDateController.text = '$month $day, $year';
      notifyListeners();
    }
  }

  selectTime(bool isStartTime) async {
    TimeOfDay selectedTime =
        isStartTime ? _addTaskModel.timeOfStart : _addTaskModel.timeOfEnd;
    final TimeOfDay? pickedTime = await showTimePicker(
        context: _context,
        initialTime: selectedTime,
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child ?? const SizedBox.shrink());
        });
    if (pickedTime != null && pickedTime != selectedTime) {
      if (isStartTime) {
        if (_addTaskModel.timeOfStart == pickedTime) {
          return;
        }
        _addTaskModel.timeOfStart = pickedTime;
        _selectStartTimeController.text = _addTaskModel.timeOfStart.getTime();
      } else {
        if (_addTaskModel.timeOfEnd == pickedTime) {
          return;
        }
        _addTaskModel.timeOfEnd = pickedTime;
        _selectEndTimeController.text = _addTaskModel.timeOfEnd.getTime();
      }
      notifyListeners();
    }
  }

  onCategoryTap(String title) {
    int newIndex = _categories.indexOf(title);
    if (_selectedIndex == newIndex) return;
    _selectedIndex = newIndex;
    _addTaskModel.taskType = TaskTypes.values[_selectedIndex];
    notifyListeners();
  }

  onCreateTaskTap() {
    final Task task = Task(
      title: _addTaskNameController.text,
      description: _descriptionController.text,
      type: _addTaskModel.taskType,
      dateTime: _addTaskModel.dateTime,
      taskStartTime: _addTaskModel.timeOfStart,
      taskEndTime: _addTaskModel.timeOfEnd,
    );
    Navigator.of(_context).pop(task);
  }
}
