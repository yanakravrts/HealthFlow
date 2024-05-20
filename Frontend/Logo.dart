import 'package:flutter/material.dart';
import 'getstart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(), // Змінено початковий екран на MyHomePage
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GetstartedPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Колір сторінки
      body: Center(
        child: Stack(
          clipBehavior: Clip.none, // Дозволяє додати виходящі за межі дітей області
          children: [
            Image.asset(
              'assets/logo1.gif', // Шлях до вашого GIF-логотипу
              width: 400, // Ширина логотипу
              height: 400, // Висота логотипу
              fit: BoxFit.cover, // Або можна використати BoxFit.fill для заповнення контейнера
            ),
            Positioned(
              bottom: 5,
              right: 9,
              child: Container(
                width: 90,
                height: 33,
                color: Color(0xFFF5F5F5), // Колір прямокутника
              ),
            ),
          ],
        ),
      ),
    );
  }
}