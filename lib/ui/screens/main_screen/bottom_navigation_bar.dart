import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedita_learning_project/domain/factories/screen_factory.dart';
import 'package:vedita_learning_project/ui/screens/main_screen/main_screen_view_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int index =
        context.select((MainScreenViewModel vm) => vm.currentIndex);
    final Function onTabTapped =
        context.read<MainScreenViewModel>().onTabTapped;
    ScreenFactory screenFactory = ScreenFactory();
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          screenFactory.makeHomeScreen(),
          screenFactory.makeToDoListScreen(),
          const Center(child: Text('Notification')),
          screenFactory.makeSearchScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              activeIcon: buildShaderMask(Icons.home),
              icon: const Icon(Icons.home_rounded),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: buildShaderMask(Icons.calendar_month),
              icon: const Icon(Icons.calendar_month),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: buildShaderMask(Icons.notifications),
              icon: const Icon(Icons.notifications),
              label: ''),
          BottomNavigationBarItem(
              activeIcon: buildShaderMask(Icons.search),
              icon: const Icon(Icons.search),
              label: ''),
        ],
        onTap: (index) {
          onTabTapped(index);
        },
      ),
    );
  }

  ShaderMask buildShaderMask(IconData icon) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: <Color>[Color(0xff9C2CF3), Color(0xff3A49F9)],
        ).createShader(bounds);
      },
      child: Icon(icon),
    );
  }
}
