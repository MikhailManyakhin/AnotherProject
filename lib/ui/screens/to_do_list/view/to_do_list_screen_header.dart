import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedita_learning_project/ui/screens/app_colors.dart';
import 'package:vedita_learning_project/extensions/dates_extension.dart';
import 'package:vedita_learning_project/ui/screens/to_do_list/view_model/to_do_list_view_model.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Spacer(),
        _BuildHeaderWidget(),
        _BuildScrollingDatesWidget(),
      ],
    );
  }
}

class _BuildHeaderWidget extends StatelessWidget {
  const _BuildHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final month = DateTime.now().getMonthName();
    final year = DateTime.now().year;
    final onPressed = context.read<ToDoListViewModel>().onAddTaskPressed;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.072, vertical: 20),
      child: SizedBox(
        height: height * 0.052,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                '$month, $year',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 100),
              ),
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
                          'Add task',
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

class _BuildScrollingDatesWidget extends StatelessWidget {
  const _BuildScrollingDatesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final scrollController =
        context.select((ToDoListViewModel vm) => vm.scrollController);
    final pickedDate = context.select((ToDoListViewModel vm) => vm.dateTime);
    final onChangeDate = context.read<ToDoListViewModel>().changeDate;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: height * 123 / 1337,
        child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: DateTime.now().numberOfDaysInMonth(),
            itemExtent: width * 85 / 619,
            itemBuilder: (context, index) {
              index++;
              return GestureDetector(
                  onTap: () {
                    onChangeDate(pickedDate
                        .add(Duration(days: (index - pickedDate.day).toInt())));
                  },
                  child: DateWidget(index));
            }),
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  final int index;
  const DateWidget(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDate = context.select((ToDoListViewModel vm) => vm.dateTime);
    final DateTime currentDateTime =
        DateTime(DateTime.now().year, DateTime.now().month, index);
    return DecoratedBox(
      decoration: index == selectedDate?.day || selectedDate == null
          ? ShapeDecoration(
              gradient: AppColors.datesFieldGradient,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)))
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
      child: FittedBox(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(currentDateTime.getWeekdayName(),
                  style: index == selectedDate?.day
                      ? TextStyle(
                          fontWeight: FontWeight.w500,
                          foreground: Paint()..shader = AppColors.textGradient,
                        )
                      : const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)),
              Text(
                currentDateTime.day.toString(),
                style: index == selectedDate?.day
                    ? TextStyle(
                        foreground: Paint()..shader = AppColors.textGradient,
                        fontWeight: FontWeight.w300)
                    : const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ),
    );
  }
}
