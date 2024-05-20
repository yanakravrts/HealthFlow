import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SearchPage(),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 900,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, 1),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 55,
              left: -20,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('Back button clicked');
                },
                child: Image.asset(
                  'assets/back.png',
                  fit: BoxFit.cover,
                  width: 320,
                  height: 110,
                ),
              ),
            ),
            Positioned(
              top: 112,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    FormInputWithBorder(
                      TextEditingController(),
                      "Введіть назву лабораторії",
                    ),
                    const SizedBox(height: 300),
                    FormInputWithBorder(
                      TextEditingController(),
                      "Лабораторії:  ",
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 310,
              child: Transform.scale(
                scale: 0.58,
                child: Image.asset('assets/search.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 280,
              left: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 4,
                    child: Image.asset('assets/map.png', width: 100, height: 100),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _launchMaps(); // Викликаємо функцію для відкриття карти
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: const Color.fromRGBO(34, 151, 161, 1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 400, sigmaY: 400),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Показати на карті',
                              style: TextStyle(
                                color: const Color.fromRGBO(34, 151, 161, 1),
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),

            // Існуючі прямокутники
            Positioned(
              top: 570,
              left: 32,
              child: Container(
                width: 363,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: 710,
              left: 32,
              child: Container(
                width: 363,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: 580,
              left: 58,
              child: Transform.scale(
                scale: 1.5,
                child: Image.asset('assets/esculab.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 720,
              left: 58,
              child: Transform.scale(
                scale: 1.5,
                child: Image.asset('assets/Medic.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 600,
              left: 240,
              child: Text(
                'Час роботи',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(143, 142, 142, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 740,
              left: 240,
              child: Text(
                'Час роботи',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(143, 142, 142, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 610,
              left: 202,
              child: Transform.scale(
                scale: 0.67,
                child: Image.asset('assets/tochka.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 750,
              left: 202,
              child: Transform.scale(
                scale: 0.67,
                child: Image.asset('assets/tochka.png', width: 100, height: 100),
              ),
            ),

            // Прямокутники, що гортатимуться горизонтально під існуючими прямокутниками
            Positioned(
              top: 850,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 363,
                      margin: EdgeInsets.only(left: 32, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: 363,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: 363,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
void _launchMaps() async {
  const url = 'https://www.google.com/maps'; // URL для відкриття Google Maps
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


class FormInputWithBorder extends StatelessWidget {
  const FormInputWithBorder(
      this._controller,
      this._placeholder, {
        Key? key,
      }) : super(key: key);

  final TextEditingController _controller;
  final String _placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 370,
      height: 70,
      margin: const EdgeInsets.only(left: 10, top: 2),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1), // Змініть колір фону тут
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(34, 151, 161, 1),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
          hintText: _placeholder,
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.44),
          fontFamily: 'Inter',
          fontSize: 20,
        ),
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
      width: 370,
      height: 70,
      margin: const EdgeInsets.only(left: 10, top: 2),
      decoration: BoxDecoration(
        color: Color.fromRGBO(217, 217, 217, 0.32),
        boxShadow: [],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(children: [
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
      ]),
    );
  }
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

