import 'package:flutter/material.dart';

//* ------------------------ Верстка ------------------------------------------

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SimpleCalcWidget(),
      ),
    );
  }
}

//*  данный виджет никогда не будет вызывать setState, он нужен чисто для хранения модели:
class SimpleCalcWidget extends StatefulWidget {
  const SimpleCalcWidget({Key? key}) : super(key: key);

  @override
  State<SimpleCalcWidget> createState() => _SimpleCalcWidgetState();
}

class _SimpleCalcWidgetState extends State<SimpleCalcWidget> {
  // храним ссылку на модель:
  final _model = SimpleCalcWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),

        // оборачиваем всю колонку в данный виджет:
        child: SimpleCalcWidgetProvider<SimpleCalcWidgetModel>(
          // и передаем в него модель:
          model: _model,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FirstNumberWidget(),
              SizedBox(height: 15),
              SecondNumberWidget(),
              SizedBox(height: 15),
              SubmitButtonWidget(),
              SizedBox(height: 15),
              ResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstNumberWidget extends StatelessWidget {
  const FirstNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),

      // если что-то изменилось в поле,
      // то мы записываем это в нашу модель (обновляем ее данные):
      onChanged: (value) =>
          SimpleCalcWidgetProvider.read<SimpleCalcWidgetModel>(context)
              ?.firstNumber = value,
    );
  }
}

class SecondNumberWidget extends StatelessWidget {
  const SecondNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),

      // если что-то изменилось в поле,
      // то мы записываем это в нашу модель (обновляем ее данные):
      onChanged: (value) =>
          SimpleCalcWidgetProvider.read<SimpleCalcWidgetModel>(context)
              ?.secondNumber = value,
    );
  }
}

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // при нажатии на кнопку вызывается метод модели,
      // на сложение двух данных из полей:
      onPressed: () =>
          SimpleCalcWidgetProvider.read<SimpleCalcWidgetModel>(context)
              ?.summ(),
      child: const Text('Result'),
    );
  }
}

//* заменили на stateless, так используем инхерит Inherited Notifier
class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = SimpleCalcWidgetProvider.watch<SimpleCalcWidgetModel>(context)
            ?.summResult ??
        '0';
    return Text('Result: $value');
  }
}

//* нужен для примера с инхеритом InheritedWidget
// class ResultWidget extends StatefulWidget {
//   const ResultWidget({Key? key}) : super(key: key);

//   @override
//   State<ResultWidget> createState() => _ResultWidgetState();
// }

// class _ResultWidgetState extends State<ResultWidget> {
//   String _value = '0';

//   // тут мы оформляем подписку на наш провайдер и получаем изменения,
//   // т.к didChangeDependencies() вызывается один раз то он будет оформлять ее вначале:
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     setState(() {
//       final model = SimpleCalcWidgetProvider.of(context)?.model;
//       model?.addListener(() {
//         _value = '${model.summResult}';
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text('Result: $_value');
//   }
// }

//* ------------------------ Логика ------------------------------------------

//* моделька с логикой, отдельно от верстки, она наследуется от ChangeNotifier,
//* данный класс дает возможность подписаться на него и получать изменения,
//* а внутри него можно вызвать notifyListeners(), который посылает уведомление,
//* что были внесены изменения:

class SimpleCalcWidgetModel extends ChangeNotifier {
  // модель нужна для хранения наших данных, которые будут получены из полей:
  int? _firstNumber;
  int? _secondNumber;
  int? summResult;

  // сеттеры для преобразования строк в числа:
  set firstNumber(String value) => _firstNumber = int.tryParse(value);
  set secondNumber(String value) => _secondNumber = int.tryParse(value);

  // функция суммирования:
  void summ() {
    // создаем локальную переменную:
    int? summResult;

    if (_firstNumber != null && _secondNumber != null) {
      summResult = _firstNumber! + _secondNumber!;
    } else {
      summResult = null;
    }
    if (this.summResult != summResult) {
      // если значение изменилось, то меняем сумму и обновляем данные,
      // а если сумма не изменилась, то ничего не трогаем. Круто)
      this.summResult = summResult;
      notifyListeners();
    }
  }
}

//* ------------------------ Провайдер ------------------------------------------

//* провайдер, виджет инхерит, использование InheritedNotifier:
class SimpleCalcWidgetProvider<T extends ChangeNotifier>
    extends InheritedNotifier<T> {
  // передаем модель в наш провайдер:
  final T model;

  // тут мы передаем нашу модель инхериту:
  const SimpleCalcWidgetProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, child: child, notifier: model);

  // статические функции helper которые упрощают вызов dependOnInheritedWidgetOfExactType у контекста,
  // делает запись покороче, сахарок. Он тут уже возвращает модель (еще упростили):
  static T? watch<T extends ChangeNotifier>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider<T>>();

    if (provider != null) {
      return provider.notifier as T;
    } else {
      return null;
    }
  }

  static T? read<T extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<SimpleCalcWidgetProvider<T>>()
        ?.widget;

    return widget is SimpleCalcWidgetProvider ? widget.notifier as T : null;
  }
}


//* Использование InheritedWidget
// class SimpleCalcWidgetProvider extends InheritedWidget {
//   // передаем модель в наш провайдер:
//   final SimpleCalcWidgetModel model;

//   const SimpleCalcWidgetProvider({
//     Key? key,
//     required Widget child,
//     required this.model,
//   }) : super(key: key, child: child);

//   // статические функции helper которые упрощают вызов dependOnInheritedWidgetOfExactType у контекста,
//   // делает запись покороче, сахарок)
//   static SimpleCalcWidgetProvider? of(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>();
//   }

//   // если изменится наша модель, то инхерит заставит вызвать build у тех виджетов которые он обернул
//   @override
//   bool updateShouldNotify(SimpleCalcWidgetProvider oldWidget) {
//     return model != oldWidget.model;
//   }
// }
