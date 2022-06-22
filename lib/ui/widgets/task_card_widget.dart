import 'package:flutter/material.dart';
import 'package:vedita_learning_project/domain/entity/task.dart';
import 'package:vedita_learning_project/ui/screens/app_colors.dart';
import 'package:vedita_learning_project/ui/screens/app_images.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    Key? key,
    required this.task,
    required this.days,
    required this.hours,
    required this.minutesStr,
  }) : super(key: key);
  final Task task;
  final int days;
  final int hours;
  final String minutesStr;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Card(
        margin: EdgeInsets.symmetric(vertical: 12 / 1337 * height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 / 619 * width),
        ),
        child: Row(children: [
          Padding(
            padding: EdgeInsets.all(30 / 619 * width),
            child: SizedBox(
                width: 60.96,
                height: 60.96,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: AppColors.gradient,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(15 / 619 * width),
                    child: AppImages.toDoListIcon,
                  ),
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Text(
                  (days == 0 ? '' : '$days days ') +
                      (hours == 0 ? '' : '$hours hours ') +
                      minutesStr,
                  style: const TextStyle(
                      color: AppColors.additionalCardTextColor)),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: AppColors.greyColor))
        ]));
  }
}
