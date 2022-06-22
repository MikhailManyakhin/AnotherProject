import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vedita_learning_project/domain/data_provider/hive_provider.dart';
import 'package:vedita_learning_project/domain/entity/project.dart';
import 'package:vedita_learning_project/domain/entity/task.dart';
import 'package:vedita_learning_project/ui/naviagtion/main_navigation.dart';
import 'package:vedita_learning_project/ui/screens/main_screen/main_screen_view_model.dart';

class HomeScreenModel extends ChangeNotifier {
  final BuildContext _context;
  final _pageScrollController = ScrollController();
  late final Future<Box<Project>> _projectBox;
  late Future<Box<Task>> _taskBox;
  ValueListenable? _projectListenable;
  ValueListenable? _taskListenable;
  List<Task> _tasks = [];
  List<Project> _projects = [];
  final List<String> _categories = ['My Tasks', 'In-progress', 'Completed'];
  int _selectedCategoryIndex = 0;
  int? _activeProjectIndex;
  int _dotesIndex = 0;
  double _projectPageSize = 0;

  ///Test name project
  final _projectNameController = TextEditingController();

  ScrollController get pageScrollController => _pageScrollController;
  TextEditingController get projectNameController => _projectNameController;
  int? get activeProjectIndex => _activeProjectIndex;
  List<Task> get tasks => _tasks;
  List<Project> get projects => _projects;
  int get dotesIndex => _dotesIndex;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  List<String> get categories => _categories;

  //TODO: fix
  final MainScreenViewModel _mainScreenViewModel;
  HomeScreenModel(this._context, this._mainScreenViewModel) {
    _loadData();
  }

  _loadData() async {
    _pageScrollController.addListener(_pageControllerListener);

    _projectBox = HiveProvider.instance.openProjectBox();

    _projectListenable = (await _projectBox).listenable();
    _projectListenable?.addListener(_readProjectsFromHive);

    if ((await _projectBox).isEmpty) return;

    await _readProjectsFromHive();

    _activeProjectIndex =
        _mainScreenViewModel.projectIndex;


    /// 3.1 Устанавливаем таскбокс, который соответствует ключу выбранного проекта
    /// Также вешаем на него listener
    /// Написан отдельный метод, так-как он будет переиспользоваться при переключении проекта
    await _setTaskBox();

    await _readTasksFromHive();
  }

  _pageControllerListener() {
    double scrolled = _pageScrollController.position.pixels;
    _projectPageSize = 365 * MediaQuery.of(_context).size.width / 619;
    int newIndex = (scrolled ~/ _projectPageSize);
    if ((scrolled / _projectPageSize) * 10 - newIndex * 10 > 5 ||
        scrolled == _pageScrollController.position.maxScrollExtent) {
      newIndex++;
    }
    if (_dotesIndex != newIndex) {
      _dotesIndex = newIndex;
      notifyListeners();
    }
  }

  Future<void> _readProjectsFromHive() async {
    _projects = (await _projectBox).values.toList();
    notifyListeners();
  }

  Future<void> _setTaskBox() async {
    _taskBox = HiveProvider.instance.openTaskBox(_activeProjectIndex!);
    await _readTasksFromHive();
    _taskListenable = (await _taskBox).listenable();
    _taskListenable?.addListener(_readTasksFromHive);
  }

  Future<void> _readTasksFromHive() async {
    _tasks = (await _taskBox).values.toList();
    notifyListeners();
  }

  Future<void> onAddProject() async {
    if (_projectNameController.text.isEmpty) return;
    Project project = Project(projectTitle: _projectNameController.text);
    (await _projectBox).add(project);
    _activeProjectIndex ??= (await _projectBox).keys.first;
    _projectNameController.clear();
  }

  onCategoryTap(String title) {
    int newIndex = _categories.indexOf(title);
    if (_selectedCategoryIndex == newIndex) return;
    _selectedCategoryIndex = newIndex;
    notifyListeners();
  }

  removeTask(int index) async {
    (await _taskBox).deleteAt(index);
  }

  onProjectChanged(int newIndex) async {
    if (newIndex == _activeProjectIndex) return;
    _activeProjectIndex = newIndex;
    _mainScreenViewModel.projectIndex = activeProjectIndex;
    await _setTaskBox();
  }

  ///Temp addTask
  onAddTaskPressed() {
    Navigator.pushNamed(_context, Routes.addTask).then((task) {
      if (task != null) {
        addTask(task as Task);
      }
    });
  }

  addTask(Task task) async {
    if (activeProjectIndex == null) return;
    _taskBox = HiveProvider.instance
        .openTaskBox((await _projectBox).keyAt(activeProjectIndex!));
    (await _taskBox).add(task);
    await _readTasksFromHive();
  }
}
