import 'package:flutter/material.dart';
import 'birthday.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordPage(),
    );
  }
}

class PasswordPage extends StatelessWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(85, 162, 166, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 354,
              height: 195,
              child: Text(
                'Створити пароль',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                  color: Color.fromRGBO(245, 245, 245, 1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 202),
            Container(
              width: 320,
              height: 69,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Пароль',
                ),
              ),
            ),
            const SizedBox(height: 46),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BirthdayPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(34, 151, 161, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Container(
                width: 295,
                height: 60,
                alignment: Alignment.center,
                child: const Text(
                  'Далі',
                  style: TextStyle(
                    color: const Color.fromRGBO(245, 245, 245, 1),
                    fontSize: 22,
                  ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
