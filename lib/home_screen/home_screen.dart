import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('/pages'),
          child: const Text('Войти'),
        ),
      ),
    );
  }
}
