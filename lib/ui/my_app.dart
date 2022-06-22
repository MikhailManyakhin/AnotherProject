import 'package:flutter/material.dart';
import 'package:vedita_learning_project/ui/screens/app_colors.dart';
import 'package:vedita_learning_project/ui/naviagtion/main_navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainNavigation mainNavigation = MainNavigation();
    return MaterialApp(
      initialRoute: Routes.mainScreen,
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      theme: ThemeData(
        backgroundColor: AppColors.backgroundColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: AppColors.greyColor,
        ),
        // textTheme: TextTheme()
      ),
    );
  }
}
