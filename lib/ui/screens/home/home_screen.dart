import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedita_learning_project/domain/entity/task.dart';
import 'package:vedita_learning_project/extensions/dates_extension.dart';
import 'package:vedita_learning_project/ui/screens/app_colors.dart';
import 'package:vedita_learning_project/ui/screens/home/home_screnn_view_model.dart';
import 'package:vedita_learning_project/ui/screens/to_do_list/view_model/to_do_list_view_model.dart';
import 'package:vedita_learning_project/ui/widgets/category_card_widget.dart';
import 'package:vedita_learning_project/ui/widgets/task_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Не стоит отображать полосу прокрутки, а также что-либо на экране
    //TODO: кроме предложения создать первый проект, когда проектов 0 и тасков, соответственно 0
    final projects = context.select((HomeScreenModel vm) => vm.projects);

    final sliversIfProjectsExist = [
      const _BuildCategoryCardsWidget(),
      const _BuildSlidingProjectWidget(),
      const _BuildSlidingDotesWidget(),
      const _BuildTaskTitleWidget(),
      const _BuildTaskListWidget(),
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _BuildAppBarWidget(),
          const _BuildNameLabelWidget(),
          ...projects.isEmpty
              ? [const _BuildAddFirstProjectWidget()]
              : sliversIfProjectsExist
        ],
      ),
    );
  }
}

class _BuildAddFirstProjectWidget extends StatelessWidget {
  const _BuildAddFirstProjectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onPressed = context.read<HomeScreenModel>().onAddProject;
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          children: [
            const Text(
              'Add first project',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textAndIconColor),
            ),
            AspectRatio(
              aspectRatio: 171 / 70,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(75)),
                  gradient: AppColors.gradient,
                ),
                child: MaterialButton(
                  height: double.infinity,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: FittedBox(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          'Add project',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildAppBarWidget extends StatelessWidget {
  const _BuildAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final projectNameController =
        context.select((HomeScreenModel vm) => vm.projectNameController);
    final addProject = context.read<HomeScreenModel>().onAddProject;
    final onAddTaskPressed = context.read<HomeScreenModel>().onAddTaskPressed;
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.textAndIconColor,
      leading: Padding(
        padding: EdgeInsets.only(left: 0.08 * width),
        child: IconButton(
          icon: const Icon(Icons.view_headline_sharp),
          onPressed: onAddTaskPressed,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 59 / 619 * width),
          child: GestureDetector(
            onTap: () {
              /// Кажется так проще, когда речь идет о временном (тестовом) виджете
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Project name',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    controller: projectNameController,
                  ),
                  action: SnackBarAction(
                    label: 'Add Project',
                    onPressed: addProject,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.account_circle,
              color: AppColors.textAndIconColor,
            ),
          ),
        )
      ],
    );
  }
}

class _BuildNameLabelWidget extends StatelessWidget {
  const _BuildNameLabelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: EdgeInsets.only(top: 55 / 1337 * height, left: 50 / 619 * width),
      sliver: SliverToBoxAdapter(
        child: ListTile(
          title: const Text(
            'Hello Rohan!',
            style: TextStyle(
                color: AppColors.textAndIconColor,
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            'Have a nice day.',
            style: TextStyle(
                color: AppColors.textAndIconColor.withOpacity(0.54),
                fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class _BuildCategoryCardsWidget extends StatelessWidget {
  const _BuildCategoryCardsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final categories = context.select((HomeScreenModel vm) => vm.categories);
    final selectedCategoryIndex =
        context.select((HomeScreenModel vm) => vm.selectedCategoryIndex);
    final onCategoryTap = context.read<HomeScreenModel>().onCategoryTap;
    return SliverPadding(
      /// Неколько удобнее писать результат деления и иметь представление об отступах
      /// Хотя в данном случае горизонтальный паддинг не нужен.
      padding: EdgeInsets.only(
        top: 0.038 * height,
        bottom: 0.015 * height,
      ),
      sliver: SliverToBoxAdapter(
        child:

            /// в данном случае удобнее заменить принудительное присвоение размера на shrinkWrap
            /// p.s. всего 3 элемента. Не получим удар по перформансу, даже если заранее высчитаем их размер
            GridView.builder(
          shrinkWrap: true,

          /// Этот паддинг будет влиять на содержимое билдера, сейчас он не обрезан (убрал из сливерпаддинга)
          padding: EdgeInsets.symmetric(horizontal: 0.08 * width),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10 / 1337 * height,
            childAspectRatio: 156 / 70,
          ),
          itemBuilder: (BuildContext context, int index) {
            return CategoryCardWidget(
              title: categories[index],
              isSelected: index == selectedCategoryIndex,
              onTap: onCategoryTap,
              selectedTextColor: AppColors.textAndIconColor,
              unselectedTextColor: AppColors.textAndIconColor,
              unselectedBackgroundColor: AppColors.unselectedCardColor,
              selectedBackgroundColor: Colors.white,
            );
          },
          itemCount: categories.length,
        ),
        // ),
      ),
    );
  }
}

class _BuildSlidingProjectWidget extends StatelessWidget {
  const _BuildSlidingProjectWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final scrollController =
        context.select((HomeScreenModel vm) => vm.pageScrollController);
    final onProjectChanged = context.read<HomeScreenModel>().onProjectChanged;
    final projects = context.select((HomeScreenModel vm) => vm.projects);
    return SliverPadding(
      padding: EdgeInsets.only(top: 32 / 1337 * height),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 341 / 619 * width,
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(left: 50 / 619 * width),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final title =
                  context.read<HomeScreenModel>().projects[index].projectTitle;
              return SlidingProject(
                projectName: 'Project $index',
                onProjectTap: onProjectChanged,
                title: title,
                dateTime: DateTime.now(),
                rightPadding: 24 / 619 * width,
                projectIndex: index,
              );
            },
            itemCount: projects.length,
          ),
        ),
      ),
    );
  }
}

class SlidingProject extends StatelessWidget {
  final String projectName;
  final String title;
  final DateTime dateTime;
  final int projectIndex;
  final Function onProjectTap;
  final double rightPadding;
  const SlidingProject(
      {Key? key,
      required this.projectName,
      required this.onProjectTap,
      required this.title,
      required this.dateTime,
      required this.rightPadding,
      required this.projectIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const oldBoxSize = 341;
    final double boxSize = oldBoxSize / 619 * width;
    final selectedProject =
        context.select((HomeScreenModel vm) => vm.activeProjectIndex);

    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: GestureDetector(
        child: Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(
              gradient: projectIndex == selectedProject
                  ? AppColors.gradient
                  : AppColors.gradientWithOpacity,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(37 / oldBoxSize * boxSize),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.account_circle, color: Colors.white),
                Padding(
                  padding: EdgeInsets.only(left: 18 / oldBoxSize * boxSize),
                  child: Text(
                    projectName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 38 / oldBoxSize * boxSize),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60 / oldBoxSize * boxSize),
                child: Text(
                  dateTime.getMonthName() +
                      ' ' +
                      dateTime.day.toString() +
                      ', ' +
                      dateTime.year.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ),
        ),
        onTap: () {
          onProjectTap(projectIndex);
        },
      ),
    );
  }
}

class _BuildSlidingDotesWidget extends StatelessWidget {
  const _BuildSlidingDotesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final projects = context.select((HomeScreenModel vm) => vm.projects);
    final dotesIndex = context.select((HomeScreenModel vm) => vm.dotesIndex);
    return SliverPadding(
      padding: EdgeInsets.only(top: 29 / 1337 * height),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              dotesIndex,
              (index) {
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.greyColor),
                );
              },
            ),
            Container(
                width: 42,
                height: 10,
                decoration: BoxDecoration(
                    gradient: AppColors.gradient,
                    borderRadius: BorderRadius.circular(78))),
            ...List.generate(
              (projects.length - dotesIndex - 1) <= 0
                  ? 0
                  : (projects.length - dotesIndex - 1),
              (index) {
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.greyColor),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildTaskTitleWidget extends StatelessWidget {
  const _BuildTaskTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: EdgeInsets.only(
          left: 0.081 * width, top: 0.036 * height, bottom: 0.027 * height),
      sliver: const SliverToBoxAdapter(
        child: Text(
          'Progress',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _BuildTaskListWidget extends StatelessWidget {
  const _BuildTaskListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = context.select((HomeScreenModel vm) => vm.tasks);
    final removeTask = context.read<HomeScreenModel>().removeTask;

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
