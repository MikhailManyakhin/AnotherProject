import 'package:flutter/material.dart';
import 'package:vedita_learning_project/domain/data_provider.dart';
import 'package:vedita_learning_project/ui/screens/add_task/view_model/add_task_view_model.dart';
import 'package:vedita_learning_project/ui/screens/app_colors.dart';

class AddTaskHeader extends StatelessWidget {
  const AddTaskHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final addTaskNameController =
        ProviderNotifier.watch<AddTaskViewModel>(context)
            ?.addTaskNameController;
    final addTaskDateController =
        ProviderNotifier.watch<AddTaskViewModel>(context)
            ?.addTaskDateController;
    final onChangeDateTapped =
        ProviderNotifier.watch<AddTaskViewModel>(context)?.onAddDatePressed ??
            () {};

    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
          ),
          onPressed: () {},
        )
      ],
      flexibleSpace: DecoratedBox(
          decoration: const BoxDecoration(gradient: AppColors.gradient),
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 40, left: 0.05 * width, right: 0.05 * width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text('Create a Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                  TextField(
                    controller: addTaskNameController,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 23),
                    decoration: const InputDecoration(
                        hintText: 'Task name',
                        hintStyle:
                            TextStyle(color: AppColors.greyColor, fontSize: 20),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.addTaskUnderlineHeaderGrey))),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Date',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 23),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.addTaskUnderlineHeaderGrey))),
                    controller: addTaskDateController,
                    onTap: () {
                      onChangeDateTapped();
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
