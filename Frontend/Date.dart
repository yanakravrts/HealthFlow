import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'uploadlook.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DatePage(),
    );
  }
}

class DatePage extends StatelessWidget {
  const DatePage({Key? key}) : super(key: key);

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
              top: 220,
              width: 413,
              height: 670,
              child: RoundedRectangle(),
            ),
            Positioned(
              top: 150,
              left: 85,
              child: Text(
                'Додати документ',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 530,
              left: 50,
              child: Text(
                'Назва',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 55,
              left: -20,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('Back button clicked');
                },
                child: Image.asset(
                  'assets/backw.png',
                  fit: BoxFit.cover,
                  width: 320,
                  height: 110,
                ),
              ),
            ),
            Positioned(
              top: 315,
              left: 50,
              right: 0,
              child: CalendarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

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
              'Дата',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
                color: const Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ],
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
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      child: Stack(
        children: [
          Positioned(height: 670, width: 413, child: MyForm()),
          Positioned(
            top: 8,
            left: -50,
            width: 261,
            height: 68,
            child: LoginLabel(),
          ),
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
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(217, 217, 217, 0.8),
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
        Positioned(
          top: 400,
          left: 4,
          height: 75,
          width: 200,
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
      ]),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton(this._onPressed, {Key? key}) : super(key: key);
  final Function()? _onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Використовуйте функцію Navigator для переходу на нову сторінку
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadLookPage()),
        );
      }, // Видаліть кому тут
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(87, 163, 167, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: TextStyle(
          color: const Color.fromRGBO(255, 254, 0, 1),
          fontFamily: 'RobotoFlex',
          fontSize: 26,
          fontWeight: FontWeight.normal,
        ),
        side: BorderSide.none,
      ),
      child: Container(
        width: 250,
        alignment: Alignment.center,
        height: 50,
        child: Text(
          'Далі',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
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


class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _titleController = TextEditingController();

  Future<void> _submitForm() async {
    final String title = _titleController.text;
    final url = Uri.parse('http://192.168.1.4:3001/Account/Login');
    final response = await http.post(
      url,
      body: {
        'title': title,
      },
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Error sending data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 350,
          left: -10,
          right: 0,
          child: Center(
            child: FormInput(_titleController, "Напишіть назву"),
          ),
        ),
        Positioned(
          top: 500,
          left: 0,
          right: 0,
          child: Center(
            child: LoginButton(_submitForm),
          ),
        ),
      ],
    );
  }
}


class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 315,
      left: 50,
      right: 0,
      child: Center(
        child: Column(
          children: [
            SizedBox(width: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCalendarColumn(
                        title: 'День',
                        itemCount: _getDaysInMonth(selectedMonth ?? 1),
                        onItemSelected: (index) {
                          setState(() {
                            selectedDay = index + 1;
                          });
                        },
                        isSelected: (index) => selectedDay == index + 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCalendarColumn(
                        title: 'Місяць',
                        itemCount: 12,
                        onItemSelected: (index) {
                          setState(() {
                            selectedMonth = index + 1;
                          });
                        },
                        isSelected: (index) => selectedMonth == index + 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 65),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCalendarColumn(
                        title: 'Рік',
                        itemCount: 100,
                        onItemSelected: (index) {
                          setState(() {
                            selectedYear = DateTime.now().year - index;
                          });
                        },
                        isSelected: (index) =>
                        selectedYear == DateTime.now().year - index,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarColumn({
    required String title,
    required int itemCount,
    required Function(int) onItemSelected,
    required bool Function(int) isSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        SizedBox(
          height: 130, // Збільшено висоту рядка для відображення повних назв місяців
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final item = index + 1;
              final isSelectedItem = isSelected(index);
              final textColor = isSelectedItem ? Colors.black : Colors.grey;
              final backgroundColor = isSelectedItem
                  ? Colors.black.withOpacity(0.32)
                  : Colors.transparent;
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: Container(
                  color: backgroundColor,
                  padding: EdgeInsets.all(1),
                  child: Text(
                    title == 'Місяць'
                        ? _getMonthName(item)
                        : title == 'Рік'
                        ? '${DateTime.now().year - index}'
                        : '$item',
                    style: TextStyle(fontSize: 23, color: textColor),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Січень';
      case 2:
        return 'Лютий';
      case 3:
        return 'Березень';
      case 4:
        return 'Квітень';
      case 5:
        return 'Травень';
      case 6:
        return 'Червень';
      case 7:
        return 'Липень';
      case 8:
        return 'Серпень';
      case 9:
        return 'Вересень';
      case 10:
        return 'Жовтень';
      case 11:
        return 'Листопад';
      case 12:
        return 'Грудень';
      default:
        return '';
    }
  }

  int _getDaysInMonth(int month) {
    switch (month) {
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      case 2:
        final now = DateTime.now();
        final isLeapYear = now.year % 4 == 0 && (now.year % 100 != 0 || now.year % 400 == 0);
        return isLeapYear ? 29 : 28;
      default:
        return 31;
    }
  }
}
