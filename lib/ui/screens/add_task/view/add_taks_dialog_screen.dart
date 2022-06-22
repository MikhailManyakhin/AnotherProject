import 'package:flutter/material.dart';
import 'package:vedita_learning_project/domain/data_provider.dart';
import 'package:vedita_learning_project/ui/screens/add_task/view/add_task_dialog_header.dart';
import 'package:vedita_learning_project/ui/screens/add_task/view_model/add_task_view_model.dart';
import 'package:vedita_learning_project/ui/screens/app_colors.dart';
import 'package:vedita_learning_project/ui/widgets/category_card_widget.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ProviderNotifier.read<AddTaskViewModel>(context);
    final startTimeController =
        ProviderNotifier.watch<AddTaskViewModel>(context)?.startTimeController;
    final endTimeController =
        ProviderNotifier.watch<AddTaskViewModel>(context)?.endTimeController;
    final descriptionController =
        ProviderNotifier.watch<AddTaskViewModel>(context)?.descriptionController;
    final selectedIndex =
        ProviderNotifier.watch<AddTaskViewModel>(context)?.selectedIndex;
    final categories = model?.categories;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const AddTaskHeader(),
          DraggableScrollableSheet(
              initialChildSize: 864 / 1337,
              maxChildSize: 0.7,
              builder: (context, scrollController) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.05 * width,
                            vertical: 40 / 1337 * height),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectStartEndTimeWidget(
                                width: width,
                                startTimeController: startTimeController,
                                onStartDateTapped: model?.selectTime ?? (_) {},
                                endTimeController: endTimeController),
                            Padding(
                              padding: EdgeInsets.only(top: 40 / 1337 * height),
                              child: const Text(
                                'Description',
                                style:
                                    TextStyle(color: AppColors.addTaskBodyGrey),
                              ),
                            ),
                            TextField(
                              maxLines: null,
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors
                                              .addTaskUnderlineHeaderGrey))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30 / 1337 * height),
                              child: const Text(
                                'Category',
                                style:
                                    TextStyle(color: AppColors.addTaskBodyGrey),
                              ),
                            ),
                            SizedBox(
                              height: 245 / 1337 * height,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    EdgeInsets.only(top: 27 / 1337 * height),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10 / 1337 * height,
                                  childAspectRatio: 156 / 70,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return CategoryCardWidget(
                                    title: categories[index],
                                    onTap: model?.onCategoryTap ?? (_) {},
                                    selectedTextColor: Colors.white,
                                    unselectedBackgroundColor:
                                        AppColors.backgroundColor,
                                    isSelected: index == selectedIndex,
                                    unselectedTextColor:
                                        AppColors.textAndIconColor,
                                    selectedBackgroundGradient:
                                        AppColors.gradient,
                                  );
                                },
                                itemCount: categories.length,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30 / 1337 * height),
                              child: SizedBox(
                                height: 92 / 1337 * height,
                                child: DecoratedBox(
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(75)),
                                      gradient: AppColors.gradient,
                                    ),
                                    child: MaterialButton(
                                      onPressed: model?.onCreateTaskTap,
                                      child: const Center(
                                        child: Text(
                                          'Create Task',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 23),
                                        ),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}

class SelectStartEndTimeWidget extends StatelessWidget {
  const SelectStartEndTimeWidget({
    Key? key,
    required this.width,
    required this.startTimeController,
    required this.onStartDateTapped,
    required this.endTimeController,
  }) : super(key: key);

  final double width;
  final TextEditingController startTimeController;
  final void Function(bool p1) onStartDateTapped;
  final TextEditingController endTimeController;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Start Time',
            style: TextStyle(color: AppColors.addTaskBodyGrey),
          ),
          TextField(
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.addTaskUnderlineHeaderGrey)),
                constraints: BoxConstraints(maxWidth: 0.45 * width)),
            controller: startTimeController,
            readOnly: true,
            onTap: () {
              onStartDateTapped(true);
            },
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'End Time',
            style: TextStyle(color: AppColors.addTaskBodyGrey),
          ),
          TextField(
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.addTaskUnderlineHeaderGrey)),
                constraints: BoxConstraints(maxWidth: 0.45 * width)),
            controller: endTimeController,
            readOnly: true,
            onTap: () {
              onStartDateTapped(false);
            },
          ),
        ],
      )
    ]);
  }
}
