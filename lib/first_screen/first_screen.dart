import 'package:flutter/material.dart';

// используем ключ для получение контекст из любого виджета, лучше так не делать
final key = GlobalKey<_ColoredWidgetState>();

class FirstScreen extends StatelessWidget {
  const FirstScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ColoredWidget(
          initalColor: Colors.red,
          child: Padding(
            padding: EdgeInsets.all(40),
            child: ColoredWidget(
              key: key,
              initalColor: Colors.green,
              child: const Padding(
                padding: EdgeInsets.all(40),
                child: ColorButton(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ColoredWidget extends StatefulWidget {
  final Color initalColor;
  final Widget child;

  const ColoredWidget({
    Key? key,
    required this.initalColor,
    required this.child,
  }) : super(key: key);

  @override
  State<ColoredWidget> createState() => _ColoredWidgetState();
}

class _ColoredWidgetState extends State<ColoredWidget> {
  late Color color;

  @override
  void initState() {
    color = widget.initalColor;
    super.initState();
  }

  void changeColor(Color color) {
    setState(() {
      this.color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    // проверка чей контекст мы получаем
    // print('🔴 ---> ${context.widget.runtimeType}');
    return Container(
      color: color,
      child: widget.child,
    );
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({Key? key}) : super(key: key);

  // void _onPressed(BuildContext context) {
  //   context
  //       // метод предка, виджет который находится за этим, мы указываем стейт
  //       .findAncestorStateOfType<_ColoredWidgetState>()
  //       ?.changeColor(Colors.pink);

  //   context
  //       // метод последнего виджета с данным стейтом
  //       .findRootAncestorStateOfType<_ColoredWidgetState>()
  //       ?.changeColor(Colors.yellow);
  // }

  @override
  Widget build(BuildContext context) {
    return const ColoredWidget(
      initalColor: Colors.blue,
      child: SomeWidget(),
    );
  }
}

// создали отдельный виджет, чтобы получить его контекст, лучший вариант и мы пользуемся его build
// но также можно было бы воспользоваться Builder в него передали контекст и вернули бы виджет другой
class SomeWidget extends StatelessWidget {
  const SomeWidget({Key? key}) : super(key: key);

  void _onPressed(BuildContext context) {
    context
        // метод предка, виджет который находится за этим, мы указываем стейт
        .findAncestorStateOfType<_ColoredWidgetState>()
        ?.changeColor(Colors.pink);

    context
        // метод последнего виджета с данным стейтом
        .findRootAncestorStateOfType<_ColoredWidgetState>()
        ?.changeColor(Colors.yellow);

      // методы виджета по ключу, но лучше не делать глобальные переменные
      key.currentState?.changeColor(Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _onPressed(context),
        child: const Text('Нажми'),
      ),
    );
  }
}