import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedita_learning_project/domain/entity/task.dart';
import 'package:vedita_learning_project/ui/screens/app_colors.dart';
import '''package:vedita_learning_project/ui/screens/to_do_list/view/to_do_list_screen_header.dart''';
import 'package:vedita_learning_project/ui/screens/to_do_list/view_model/to_do_list_view_model.dart';
import 'package:vedita_learning_project/ui/widgets/task_card_widget.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CustomScrollView(
      slivers: [
        _BuildHeaderWidget(),
        _BuildTaskTitleWidget(),
        _BuildScrollingTasksWidget()
      ],
    ));
  }
}

class _BuildTaskTitleWidget extends StatelessWidget {
  const _BuildTaskTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: EdgeInsets.only(
          top: 53 / 1337 * height,
          bottom: 45 / 1337 * height,
          left: 49 / 619 * width),
      sliver: const SliverToBoxAdapter(
        child: Text(
          'Tasks',
          style: TextStyle(
              color: AppColors.textAndIconColor,
              fontWeight: FontWeight.w600,
              fontSize: 32),
        ),
      ),
    );
  }
}

class _BuildScrollingTasksWidget extends StatelessWidget {
  const _BuildScrollingTasksWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final tasks = context.select((ToDoListViewModel vm) => vm.tasks);
    final removeTask = context.read<ToDoListViewModel>().removeTask;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final Task task = tasks[index];
        final int days = daysOnTaskRemaining(task);
        final int hours = hoursOnTasRemaining(task);
        final int minutes = minutesOnTaskRemaining(task);
        String minutesStr = minutesRemainingTitle(days, hours, minutes);
        return Dismissible(
          direction: DismissDirection.endToStart,
          child: FractionallySizedBox(
            widthFactor: 0.842,
            child: TaskCardWidget(
                task: task, days: days, hours: hours, minutesStr: minutesStr),
          ),
          onDismissed: (_) {
            removeTask(index);
          },
          key: ValueKey<Task>(tasks[index]),
        );
      }, childCount: tasks.length),
    );
  }
}

class _BuildHeaderWidget extends StatelessWidget {
  const _BuildHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      foregroundColor: Colors.black,
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      elevation: 15,
      shadowColor: AppColors.shadowColor,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: AppColors.textAndIconColor,
          ),
          onPressed: () {},
        )
      ],
      flexibleSpace: const FlexibleSpaceBar(background: Header()),
    );
  }
}
