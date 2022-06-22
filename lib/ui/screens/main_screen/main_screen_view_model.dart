import 'package:flutter/material.dart';
import 'package:vedita_learning_project/domain/data_provider/hive_provider.dart';

class MainScreenViewModel extends ChangeNotifier {
  // final BuildContext _context;
  int _currentIndex = 0;
  int? _projectIndex;
  int? get projectIndex => _projectIndex;
  set projectIndex(int? value) {
    _projectIndex = value;
    notifyListeners();
  }

  bool _isProjectBoxEmpty = false;
  get isProjectBoxEmpty => _isProjectBoxEmpty;
  get currentIndex => _currentIndex;

  MainScreenViewModel() {
    _openProjectBox();
  }
  _openProjectBox() async {
    _isProjectBoxEmpty = (await HiveProvider.instance.openProjectBox()).isEmpty;
    if (!isProjectBoxEmpty) {
      projectIndex = (await HiveProvider.instance.openProjectBox()).keys.first;
    }
  }

  onTabTapped(int index) {
    if (isProjectBoxEmpty && index == 1) return;
    _currentIndex = index;
    notifyListeners();
  }
}
