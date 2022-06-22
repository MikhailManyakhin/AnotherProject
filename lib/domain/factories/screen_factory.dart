import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedita_learning_project/domain/data_provider.dart';
import 'package:vedita_learning_project/ui/screens/add_task/view/add_taks_dialog_screen.dart';
import 'package:vedita_learning_project/ui/screens/add_task/view_model/add_task_view_model.dart';
import 'package:vedita_learning_project/ui/screens/main_screen/bottom_navigation_bar.dart';
import 'package:vedita_learning_project/ui/screens/home/home_screen.dart';
import 'package:vedita_learning_project/ui/screens/home/home_screnn_view_model.dart';
import 'package:vedita_learning_project/ui/screens/main_screen/main_screen_view_model.dart';
import 'package:vedita_learning_project/ui/screens/search/search_screen.dart';
import 'package:vedita_learning_project/ui/screens/search/search_view_model.dart';
import 'package:vedita_learning_project/ui/screens/to_do_list/view/to_do_list_screen.dart';
import 'package:vedita_learning_project/ui/screens/to_do_list/view_model/to_do_list_view_model.dart';

class ScreenFactory {
  Widget makeMainScreen(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenViewModel()),
        // ChangeNotifierProvider(create: (context) => HomeScreenModel(context)),
        // ChangeNotifierProvider(create: (context) => ToDoListViewModel(context))
        ChangeNotifierProxyProvider(
            create: (context) => HomeScreenModel(context,
                Provider.of<MainScreenViewModel>(context, listen: false)),
            update: (context, MainScreenViewModel mainScreenVm,
                    HomeScreenModel? homeScreenVm) =>
                homeScreenVm ?? HomeScreenModel(context, mainScreenVm)),
        ChangeNotifierProxyProvider(
            create: (context) => ToDoListViewModel(context,
                Provider.of<MainScreenViewModel>(context, listen: false)),
            update: (context, MainScreenViewModel mainScreenVm,
                    ToDoListViewModel? toDoListVm) =>
                toDoListVm ?? ToDoListViewModel(context, mainScreenVm)),
        ChangeNotifierProvider(create: (context) => SearchViewModel())
      ],
      child: const MainScreen(),
    );
  }

  Widget makeHomeScreen() {
    return const HomeScreen();
  }

  Widget makeToDoListScreen() {
    return const ToDoListScreen();
  }

  Widget makeAddTaskScreen(BuildContext context) {
    return ProviderNotifier(
        child: const AddTaskScreen(), model: AddTaskViewModel(context));
  }

  Widget makeSearchScreen(){
    return const SearchScreen();
  }
}
