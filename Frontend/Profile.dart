import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mytips.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfilePage(),
    );
  }
}

class  ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 900,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 3,
              width: 220,
              height: 220,
              child: Image.asset('assets/back.png'),
            ),
            Positioned(
              top: 70,
              left: 124,
              width: 170,
              height: 170,
              child: CircleContainer('assets/elips_home.jpg'),
            ),
            Positioned(
              top: -155,
              left: -100,
              height: 600,
              width: 700,
              child: Image.asset('assets/4.png'),
            ),
            Positioned(
              top: 320,
              width: 413,
              height: 593,
              child: RoundedRectangle(),
            ),
            Positioned(
              top: -15,
              width: 413,
              height: 593,
              child: LoginLabel(),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> sendRequest(BuildContext context) async {
  try {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.post(
      url,
      body: {
        'title': 'foo',
        'body': 'bar',
        'userId': '1',
      },
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Post request successful: $data');
    } else {
      print('Post request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending request: $e');
  }
}

// перекинути на сторінку
class LoginLabel extends StatelessWidget {
  const LoginLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 261,
      height: 68,
      child: Center(
        child: Stack(
          children: [
            Text(
              'My Profile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: const Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleContainer extends StatelessWidget {
  final String imageUrl;

  const CircleContainer(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 267,
      height: 267,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(85, 162, 166, 1),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class RoundedRectangle extends StatelessWidget {
  const RoundedRectangle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 470,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(85, 162, 166, 1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [
          Positioned(height: 700, width: 680, child: MyForm()),

        ],
      ),
    );
  }
}

class ECon extends StatelessWidget {
  const ECon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromRGBO(217, 217, 217, 0.72),
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  const FormInput(this._controller, this._placeholder, {Key? key})
      : super(key: key);
  final TextEditingController _controller;
  final String _placeholder;
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        width: 358,
        height: 80,
        margin: const EdgeInsets.only(left: 10, top: 2),
        decoration: BoxDecoration(
          color: Color.fromRGBO( 200, 200, 200,1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(children: [
          // Positioned(
          //   top: 3,
          //   left: 4,
          //   height: 75,
          //   width: 353,
          //   child: ECon(),
          // ),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 13, horizontal: 20),
              hintText: _placeholder,
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Color.fromRGBO(128, 128, 128, 1),
              fontFamily: 'Inter',
              fontSize: 23,
            ),
          ),
        ]));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton(this._onPressed, {Key? key}) : super(key: key);
  final Function()? _onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 0.89),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: TextStyle(
          color: const Color.fromRGBO(255, 254, 0, 1),
          fontFamily: 'RobotoFlex',
          fontSize: 25,
          fontWeight: FontWeight.normal,
        ),
        side: BorderSide.none,
      ),
      child: Container(
        width: 270,
        alignment: Alignment.center,
        height: 80,
        child: Text(
          'Edit',
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
        ),
      ),
    );
  }

  void sendRequest(BuildContext context) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.post(
      url,
      body: {
        'title': 'foo',
        'body': 'bar',
        'userId': '1',
      },
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Post request successful: $data');
    } else {
      print('Post request failed with status: ${response.statusCode}');
    }
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Future<void> _submitForm() async {
    final String name = _nameController.text;
    final String data = _dataController.text;
    final String email = _emailController.text;
    print(name);
    // Тут ви можете використовувати ваш URL та дані для відправки на сервер
    final url = Uri.parse('http://192.168.1.4:3001/Account/Login');
    final response = await http.post(
      url,
      body: {
        'name': name,
        'data_of_birth': name,
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      // Обробка успішної відправки
      print('Data sent successfully');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
    } else {
      // Обробка помилки відправки
      print('Error sending data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 18,
          height: 70,
          width: 370,
          child: FormInput(_nameController, "Name"),
        ),
        Positioned(
          top: 160,
          left: 18,
          height: 70,
          width: 370,
          child: FormInput(_dataController, "Date of birth"),
        ),
        Positioned(
          top: 250,
          left: 18,
          height: 70,
          width: 370,
          child: FormInput(_emailController, "Email"),
        ),
        Positioned(
          top: 440,
          left: 110,
          height: 65,
          width: 215,
          child: Center(
            child: LoginButton(
              _submitForm,
            ),
          ),
        ),
      ],
    );
  }
}
