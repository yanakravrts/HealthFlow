import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AddEventPage(),
    );
  }
}

class AddEventPage extends StatelessWidget {
  const AddEventPage({Key? key}) : super(key: key);

  Future<void> _submitForm(BuildContext context) async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();

    final String title = _titleController.text;
    final String city = _cityController.text;
    final url = Uri.parse('http://192.168.1.4:3001/Account/Login');
    final response = await http.post(
      url,
      body: {
        'title': title,
        'city': city,
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
              left: 108,
              child: Text(
                'Додати подію',
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
              top: 500,
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
              top: 635,
              left: 50,
              child: Text(
                'Місто',
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
            Positioned(
              top: 760,
              left: 0,
              right: 0,
              child: Center(
                child: LoginButton(_submitForm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Remaining code remains unchanged

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

class LoginButton extends StatelessWidget {
  const LoginButton(this._submitForm, {Key? key}) : super(key: key);
  final Function(BuildContext) _submitForm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
        _submitForm(context);
      },
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
          'Шукати',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 325,
          left: -10,
          right: 0,
          child: Center(
            child: FormInput(_titleController, "Напишіть назву"),
          ),
        ),
        Positioned(
          top: 450,
          left: -10,
          right: 0,
          child: Center(
            child: FormInput(_cityController, "Виберіть місто, де шукати"),
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
  int? selectedHour;
  int? selectedMinute;

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
                SizedBox(width: 20),
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
                SizedBox(width: 45),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCalendarColumn(
                        title: 'Година',
                        itemCount: 13,
                        onItemSelected: (index) {
                          setState(() {
                            selectedHour = 8+index;
                          });
                        },
                        isSelected: (index) => selectedHour == 8+index,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCalendarColumn(
                        title: 'Хвилина',
                        itemCount: 59,

                        onItemSelected: (index) {
                          setState(() {
                            selectedMinute = index*5;

                          });
                        },
                        isSelected: (index) => selectedMinute == index*5,
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
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          height: 130,
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
        return 'Січ';
      case 2:
        return 'Лют';
      case 3:
        return 'Бер';
      case 4:
        return 'Кві';
      case 5:
        return 'Тра';
      case 6:
        return 'Чер';
      case 7:
        return 'Лип';
      case 8:
        return 'Сер';
      case 9:
        return 'Вер';
      case 10:
        return 'Жов';
      case 11:
        return 'Лис';
      case 12:
        return 'Гру';
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
        final isLeapYear = now.year % 4 == 0 &&
            (now.year % 100 != 0 || now.year % 400 == 0);
        return isLeapYear ? 29 : 28;
      default:
        return 31;
    }
  }
}
