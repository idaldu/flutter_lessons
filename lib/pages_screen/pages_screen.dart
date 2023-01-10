import 'package:flutter/material.dart';
import 'package:lesson_47/fifth_screen/widgets/fifth_screen.dart';
import 'package:lesson_47/first_screen/first_screen.dart';
import 'package:lesson_47/fourth_screen/fourth_screen.dart';
import 'package:lesson_47/second_screen/second_screen.dart';
import 'package:lesson_47/sixth_screen/sixth_screen.dart';
import 'package:lesson_47/third_screen/third_screen.dart';

class PagesScreen extends StatelessWidget {
  const PagesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const <Widget>[
        FirstScreen(),
        SecondScreen(),
        ThirdScreen(),
        FourthScreen(),
        FifthScreen(),
        SixthScreen()
      ],
    );
  }
}
