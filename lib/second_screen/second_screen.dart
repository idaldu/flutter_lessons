import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: DataOwnerStatefull(),
        ),
      ),
    );
  }
}

class DataOwnerStatefull extends StatefulWidget {
  const DataOwnerStatefull({Key? key}) : super(key: key);

  @override
  DataOwnerStatefullState createState() => DataOwnerStatefullState();
}

class DataOwnerStatefullState extends State<DataOwnerStatefull> {
  var _valueOne = 0;
  var _valueTwo = 0;

  void _incrementOne() {
    setState(() {
      _valueOne += 1;
    });
  }

  void _incrementTwo() {
    setState(() {
      _valueTwo += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _incrementOne,
          child: const Text('Button one'),
        ),
        ElevatedButton(
          onPressed: _incrementTwo,
          child: const Text('Button two'),
        ),
        DataProviderInherited(
          valueOne: _valueOne,
          valueTwo: _valueTwo,
          child: const DataConsumerStateless(),
        ),
      ],
    );
  }
}

// создаен чисто для того, чтобы показать как инхерит работает с ним
class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // тут мы получили значение и подписались на изменения
    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'one')
            ?.valueOne ??
        0;

    // .findAncestorStateOfType<DataOwnerStatefullState>()?._value ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$value'),
        const DataConsumerStateful(),
      ],
    );
  }
}

// создаен чисто для того, чтобы показать как инхерит работает с ним
class DataConsumerStateful extends StatefulWidget {
  const DataConsumerStateful({Key? key}) : super(key: key);

  @override
  DataConsumerStatefulState createState() => DataConsumerStatefulState();
}

class DataConsumerStatefulState extends State<DataConsumerStateful> {
  @override
  Widget build(BuildContext context) {
    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'two')
            ?.valueTwo ??
        0;

    // .findAncestorStateOfType<DataOwnerStatefullState>()?._value ?? 0;
    return Text('$value');
  }
}

class DataProviderInherited extends InheritedModel {
  final int valueOne;
  final int valueTwo;

  const DataProviderInherited({
    super.key,
    required Widget child,
    required this.valueOne,
    required this.valueTwo,
  }) : super(child: child);

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant DataProviderInherited oldWidget,
    Set dependencies,
  ) {
    final isValueOneUpdate =
        valueOne != oldWidget.valueOne && dependencies.contains('one');
    final isValueTwoUpdate =
        valueTwo != oldWidget.valueTwo && dependencies.contains('two');
    return isValueOneUpdate || isValueTwoUpdate;
  }
}

// Это пример с InheritedWidget.

// class DataProviderInherited extends InheritedWidget {
//   final int valueOne;
//   final int valueTwo;

//   const DataProviderInherited({
//     super.key,
//     required Widget child,
//     required this.valueOne,
//     required this.valueTwo,
//   }) : super(child: child);

//   @override
//   bool updateShouldNotify(DataProviderInherited oldWidget) {
//     return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
//   }
// }

// пример использования getInherite и getElementForInheritedWidgetOfExactType

// T? getInherite<T>(BuildContext context) {
//   // тут мы получили значение но не подписывались на изменения
//   // сначала мы получили элемент
//   final element =
//       context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
//   // далее получили из него виджет, но так как мы не знаем тип виджета, то явно указали его
//   final widget = element?.widget;
//   // проверка если виджет равен переданному типу, тогда возвращаем его, если нет то null
//   if (widget is T) {
//     return widget as T;
//   } else {
//     return null;
//   }
// }