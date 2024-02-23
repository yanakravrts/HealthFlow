import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'displays/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 900,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(69, 154, 158, 0.9),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 90,
              left: 83,
              width: 267,
              height: 267,
              child: CircleContainer('assets/circledark.png'),
            ),
            Positioned(
              top: 89,
              left: 70,
              width: 267,
              height: 267,
              child: CircleContainer('assets/circlelight.png'),
            ),
            Positioned(
              top: 129,
              left: -7,
              height: 189,
              width: 417,
              child: Image.asset('assets/logo.jpg'),
            ),
            Positioned(
              top: 392,
              width: 413,
              height: 500,
              child: RoundedRectangle(),
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
            // Виведення контуру тексту
            Text(
              'Login',
              style: TextStyle(
                fontFamily: 'RobotoFlex',
                fontSize: 30,
                fontWeight: FontWeight.normal,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1.0
                  ..color = const Color.fromRGBO(0, 0, 0, 1), // Колір контуру
              ),
            ),
            // Фактичний текст
            Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: const Color.fromRGBO(83, 80, 80, 0.9),
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
        color: const Color.fromRGBO(255, 255, 255, 255),
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
        color: const Color.fromRGBO(237, 241, 241, 12),
        borderRadius: BorderRadius.circular(70),
        border: Border(
          top: BorderSide(color: Color.fromRGBO(171, 170, 163, 0.4), width: 4),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -59,
            left: -120,
            child: Transform.scale(
                scaleX: 0.7, scaleY: 0.72, child: Wave('assets/wave.jpg')),
          ),
          Positioned(height: 400, width: 413, child: MyForm()),
          Positioned(
            top: 9,
            left: 76, //85
            width: 261,
            height: 68,
            child: LoginLabel(),
          ),
          Positioned(
            top: 332,
            left: 26,
            child: Transform.scale(
                scale: 1,
                child: AuthorizationButton('assets/google.png', '  Google  ')),
          ),
          Positioned(
              top: 332,
              left: 215,
              child: Transform.scale(
                  scale: 1,
                  child: AuthorizationButton(
                      'assets/facebook.png', '  Facebook'))),
          Positioned(
            top: 410,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Обробник подій для тексту "Click here to create one"
                print('Navigate to account creation');
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Don’t have an account? ",
                  style: TextStyle(
                    fontFamily: 'RobotoFlex',
                    color: Color.fromRGBO(143, 142, 142, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: "Click here to create one",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'RobotoFlex',
                        color: Color.fromRGBO(62, 100, 198, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Wave extends StatelessWidget {
  final String imageUrl;

  const Wave(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 684.54,
      height: 304.61,
      child: Image.asset(imageUrl, width: 684.54, height: 304.61),
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
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color.fromRGBO(255, 255, 255, 1),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              spreadRadius: 100,
              blurRadius: 4,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]),
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
          color: Colors.white,
          boxShadow: [],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(children: [
          Positioned(
            top: 3,
            left: 4,
            height: 75,
            width: 353,
            child: ECon(),
          ),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 13, horizontal: 20),
              hintText: _placeholder,
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.44),
              fontFamily: 'Inter',
              fontSize: 20,
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
        backgroundColor: const Color.fromRGBO(87, 163, 167, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: TextStyle(
          color: const Color.fromRGBO(255, 254, 0, 1),
          fontFamily: 'RobotoFlex',
          fontSize: 23,
          fontWeight: FontWeight.normal,
        ),
        side: BorderSide.none,
      ),
      child: Container(
        width: 270,
        alignment: Alignment.center,
        height: 80,
        child: Text(
          'Log in',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
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

class AuthorizationButton extends StatelessWidget {
  const AuthorizationButton(this.imageUrl, this.text, {Key? key})
      : super(key: key);

  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 163,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(70),
          ),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          textStyle: const TextStyle(
            fontFamily: 'RobotoFlex',
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          side: BorderSide.none,
        ),
        icon: Image.asset(
          this.imageUrl,
          width: 39,
        ),
        label: Text(
          text,
          style: TextStyle(color: Color.fromRGBO(143, 142, 142, 1)),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _submitForm() async {
    final String password = _passwordController.text;
    final String email = _emailController.text;
    print(password);
    // Тут ви можете використовувати ваш URL та дані для відправки на сервер
    final url = Uri.parse('http://192.168.1.4:3001/Account/Login');
    final response = await http.post(
      url,
      body: {
        'password': password,
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      // Обробка успішної відправки
      print('Data sent successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
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
          left: 36,
          height: 60,
          width: 333,
          child: FormInput(_emailController, "Email"),
        ),
        Positioned(
          top: 145,
          left: 36,
          height: 60,
          width: 333,
          child: FormInput(_passwordController, "Password"),
        ),
        Positioned(
          top: 235,
          left: 91,
          height: 59,
          width: 231,
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
