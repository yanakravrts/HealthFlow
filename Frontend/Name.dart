import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NamePage(),
    );
  }
}

class NamePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF55A2A6),
      resizeToAvoidBottomInset: false, // Не дозволяти зміщення вмісту при вибуху клавіатури
      body: Stack(
        children: [
          Positioned(
            top: 160,
            left: 90,
            child: Container(
              width: 400,
              child: Text(
                "Як вас звати?",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 34,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 75,
            left: 20,
            child: Container(
              width: 354,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 0.5),
              ),
              child: TextField(
                controller: _nameController,
                onChanged: (value) {
                  print(value);
                },
                decoration: InputDecoration(
                  hintText: "Введіть ваше імʼя",
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 55,
            child: ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                print("Name entered: $name");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                "Далі",
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 24,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(295, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(20),
                backgroundColor: Color(0xFF2297A1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
