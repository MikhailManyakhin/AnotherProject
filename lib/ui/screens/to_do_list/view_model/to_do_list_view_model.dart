import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vedita_learning_project/domain/data_provider/hive_provider.dart';
import 'package:vedita_learning_project/domain/entity/task.dart';
import 'package:vedita_learning_project/ui/naviagtion/main_navigation.dart';
import 'package:vedita_learning_project/ui/screens/main_screen/main_screen_view_model.dart';

class ToDoListViewModel extends ChangeNotifier {
  final BuildContext _context;
  List<Task> _tasks = [];
  late Future<Box<Task>> _taskBox;
  late ValueListenable _taskListenable;
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  DateTime _dateTime = DateTime.now();

  get scrollController => _scrollController;
  get dateTime => _dateTime;
  get tasks => _tasks;

  final MainScreenViewModel _mainScreenViewModel;
  int? _projectIndex;

  ToDoListViewModel(this._context, this._mainScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final int scrollToDay = dateTime.day - 2;
      _scrollController.animateTo(
          (scrollToDay <= 0 ? 0 : scrollToDay) *
              MediaQuery.of(_context).size.width *
              85 /
              619,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeIn);
    });
    _mainScreenViewModel.addListener(_loadTaskData);
    _loadTaskData();
  }

  _loadTaskData() async {
    if (_mainScreenViewModel.isProjectBoxEmpty ||
        _projectIndex == _mainScreenViewModel.projectIndex) return;
    _projectIndex = _mainScreenViewModel.projectIndex;
    _taskBox = HiveProvider.instance
        .openTaskBox(_mainScreenViewModel.projectIndex ?? 0); //danger
    await _readTasksFromHive();
    _taskListenable = (await _taskBox).listenable();
    _taskListenable.addListener(_readTasksFromHive);
  }

  Future<void> _readTasksFromHive() async {
    var allTasks = await _taskBox.then((taskBox) => taskBox.values.toList());
    _tasks = allTasks
        .where((Task element) => element.dateTime.day == _dateTime.day)
        .toList();
    notifyListeners();
  }

  void _animateToCurrent(int index) {
    final double scrollToDay = index - 2;
    _scrollController.animateTo(
        (scrollToDay <= 0 ? 0 : scrollToDay) *
            MediaQuery.of(_context).size.width *
            85 /
            619,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn);
  }

  removeTask(int index) async {
    (await _taskBox).deleteAt(index);
  }

  changeDate(DateTime newDatetime) async {
    _dateTime = newDatetime;
    await _readTasksFromHive();
    _animateToCurrent(newDatetime.day);
  }

  addTask(Task task) async {
    (await _taskBox).add(task);
  }

  onAddTaskPressed() {
    Navigator.pushNamed(_context, Routes.addTask).then((task) {
      if (task != null) {
        addTask(task as Task);
      }
    });
  }
}

int daysOnTaskRemaining(Task task) => task.durationMinutes() ~/ 60 ~/ 24;
int hoursOnTasRemaining(Task task) =>
    (task.durationMinutes() - daysOnTaskRemaining(task) * 24 * 60) ~/ 60;
int minutesOnTaskRemaining(Task task) =>
    task.durationMinutes() -
    daysOnTaskRemaining(task) * 24 * 60 -
    hoursOnTasRemaining(task) * 60;
String minutesRemainingTitle(int days, int hours, int minutes) {
  String minutesTitle = minutes.toString() + ' minutes';
  if (minutes == 0) {
    if (days == 0 && hours == 0) {
      minutesTitle = 'No time';
    } else {
      minutesTitle = '';
    }
  }
  return minutesTitle;
}
