import 'package:flutter/material.dart';
import 'package:vedita_learning_project/domain/factories/screen_factory.dart';

abstract class Routes {
  // static const home = '/home';
  // static const schedule = '/schedule';
  static const mainScreen = '/';//main_screen';
  static const addTask = '/schedule/add_task';
}

class MainNavigation {
  final _screenFactory = ScreenFactory();

  Map<String, Widget Function(BuildContext)> get routes => {
        // Routes.home: (BuildContext context) => _screenFactory.makeHomeScreen(context),
        // Routes.schedule: (BuildContext context) => _screenFactory.makeToDoListScreen(context),
        Routes.addTask: (BuildContext context) =>
            _screenFactory.makeAddTaskScreen(context),
        Routes.mainScreen: (BuildContext context) =>
            _screenFactory.makeMainScreen(context),
      };

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
    }
  }
}
