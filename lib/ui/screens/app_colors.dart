import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const greyColor = Color(0xffD8DEF3);
  static const activeDotColor = Color(0xff7b36f5);
  static const addTaskUnderlineHeaderGrey = Color(0xffD7DDF0);
  static const addTaskBodyGrey = Color(0xffBFC8E8);
  static const additionalCardTextColor = Color(0xffAEAEB3);
  static const textAndIconColor = Color(0xff2E3A59);
  static final shadowColor = const Color(0xff725CC1).withOpacity(0.15);
  static const backgroundColor = Color(0xffF2F5FF);
  static const unselectedCardColor = Color(0xffE5EAFC);
  static final textGradient = const LinearGradient(
    colors: <Color>[Color(0xff9C2CF3), Color(0xff3A49F9)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static final datesFieldGradient = LinearGradient(
    colors: [
      const Color(0xff9C2CF3).withOpacity(0.1),
      const Color(0xff5E3AF9).withOpacity(0.1)
    ],
    begin: const Alignment(-0.2, 1.25),
    end: const Alignment(0.2, -1.25),
  );

  static const gradient = LinearGradient(
      colors: [Color(0xff3A49F9), Color(0xff9C2CF3)],
      begin: Alignment(-0.2, 1.25),
      end: Alignment(0.2, -1.25));
  static final gradientWithOpacity = LinearGradient(colors: [
    const Color(0xff3A49F9).withOpacity(0.5),
    const Color(0xff9C2CF3).withOpacity(0.5)
  ], begin: const Alignment(-0.2, 1.25), end: const Alignment(0.2, -1.25));
}
