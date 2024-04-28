import 'package:flutter/material.dart';
import 'gender.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BirthdayPage(),
    );
  }
}

class BirthdayPage extends StatefulWidget {
  @override
  _BirthdayPageState createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  int _selectedDay = 1;
  int _selectedMonth = 1;
  int _selectedYear = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF55A2A6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 370,
              height: 84,
              margin: const EdgeInsets.only(top: 40, left: 0),
              child: const Center(
                child: Text(
                  'Коли у вас день\n   народження?',
                  style: TextStyle(
                    color: Color(0xFFF5F5F5),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            const Text(
              'Дата народження',
              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _buildDayPicker(),
                  ),
                  Expanded(
                    child: _buildMonthPicker(),
                  ),
                  Expanded(
                    child: _buildYearPicker(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CalendarWidget(initialDate: DateTime.now()), // Встановлюємо поточну дату
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenderSelection()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF2297A1)),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                child: Text(
                  'Далі',
                  style: TextStyle(
                    color: const Color(0xFFF5F5F5),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayPicker() {
    return Container(
      // Your day picker implementation
    );
  }

  Widget _buildMonthPicker() {
    return Container(
      // Your month picker implementation
    );
  }

  Widget _buildYearPicker() {
    return Container(
      // Your year picker implementation
    );
  }
}
class CalendarWidget extends StatefulWidget {
  final DateTime initialDate;

  const CalendarWidget({Key? key, required this.initialDate}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialDate.day;
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCalendarColumn(
                        title: 'День',
                        itemCount: _getDaysInMonth(selectedMonth),
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
                SizedBox(width: 40),
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
                        isSelected: (index) => selectedYear == DateTime.now().year - index,
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
          height: 130,
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final item = index + 1;
              final isSelectedItem = isSelected(index);
              final textColor = isSelectedItem ? Colors.black : Color.fromARGB(255, 255, 255, 255);
              final backgroundColor = isSelectedItem ? Colors.black.withOpacity(0.32) : Colors.transparent;
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
