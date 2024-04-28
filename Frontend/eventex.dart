import 'package:flutter/material.dart';
import 'article.dart';
import 'Profile.dart';
import 'blood_bank.dart';
import 'nofile.dart';
import 'homepage.dart';
import 'package:intl/intl.dart';
import 'addevent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalendarPage(),
    );
  }
}

class Elipse extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  Elipse({
    required this.width,
    required this.height,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromRGBO(85, 162, 166, 1),
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool _menuVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(78, 171, 179, 1),
      body: Stack(
        children: [
          Positioned(
            top: 97,
            left: 20,
            child: InkWell(
              onTap: () {
                setState(() {
                  _menuVisibility = !_menuVisibility;
                });
                print('Menu Clicked');
              },
              child: Image.asset(
                'assets/menuw.png',
                width: 45,
                height: 40,
              ),
            ),
          ),
          Positioned(
            top: -28,
            width: 413,
            height: 950,
            child: RoundedRectangle(),
          ),
          Positioned(
            top: 746,
            left: -187,
            child: InkWell(
              onTap: () {
                print('Rictangle Clicked');
              },
              child: Transform.scale(
                scale: 0.53,
                child: Image.asset('assets/rictangle_home.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 646,
            left: 37,
            child: InkWell(
              onTap: () {
                print('Elipse Home Clicked');
              },
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/elipsehome.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 736,
            left: 131,
            child: InkWell(
              onTap: () {
                print('Elips Home Clicked');
              },
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/elips_home.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 791,
            left: 25,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                print('Home Clicked');
              },
              child: Transform.scale(
                scale: 0.6,
                child: Image.asset('assets/home.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 570,
            left: -45,
            child: InkWell(
              onTap: () {
                print('Calendar Clicked');
              },
              child: Transform.scale(
                scale: 0.1,
                child: Image.asset('assets/calendar.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 145,
            left: -15,
            right: -15,
            child: CustomCalendar(),
          ),

          Positioned(
            top: 780,
            left: 310,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NofilePage()),
                );
                print('Probirka Clicked');
              },
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/probirka.jpg'),
              ),
            ),
          ),
          if (_menuVisibility) CustomMyRectangle(),
        ],
      ),
    );
  }
}

class RoundedRectangle extends StatelessWidget {
  const RoundedRectangle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 412,
          height: 670,
          margin: EdgeInsets.only(top: 190),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 245, 245, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 1,
            width: 412,
            color: Color.fromRGBO(34, 151, 161, 1),
          ),
        ),
        Positioned(
          top: 570, // Встановлюємо позицію зверху
          left: 50, // Встановлюємо позицію зліва
          child: Container(
            height: 1,
            width: 390,
            color: Color.fromRGBO(34, 151, 161, 1), // Колір лінії
          ),
        ),
        Positioned(
          top: 475, // Встановлюємо позицію зверху
          left: 50, // Встановлюємо позицію зліва
          child: Container(
            height: 180, // Встановлюємо висоту лінії
            width: 1, // Встановлюємо ширину лінії
            color: Color.fromRGBO(34, 151, 161, 1), // Колір лінії
          ),
        ),
        Positioned(
          top: 480,
          left: 60,
          child: Text(
            '08:30',
            style: TextStyle(
              fontFamily: 'Roboto Flex',
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(0, 0, 0, 1),
              height: 23 / 20,
              letterSpacing: 0,
            ),
          ),
        ),
        Positioned(
          top: 573,
          left: 60,
          child: Text(
            '10:00',
            style: TextStyle(
              fontFamily: 'Roboto Flex',
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(0, 0, 0, 1),
              height: 23 / 20,
              letterSpacing: 0,
            ),
          ),
        ),


        Positioned(
          top: 410,
          left: 230,
          height: 57,
          width: 177,
          child: RoundButton(
            "Додати",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEventPage()),
                  );
              print("Button clicked!");
            },
            backgroundColor: const Color.fromRGBO(78, 171, 179, 1),
            textColor: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        Positioned(
          top: 490,
          left: 160,
          height: 70,
          width: 230,
          child: Container(
            width: 177,
            height: 57,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Esculab",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.51),
                  fontSize: 22,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(209, 229, 231, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18), // Зменшуємо радіус заокруглення кутів
                  ),
                ),
                alignment: Alignment.centerLeft, // Вирівнювання тексту ліворуч всередині кнопки
              ),
            ),
          ),
        ),


        Positioned(
          top: 475,
          left: 310,
          child: Transform.scale(
            scale: 0.5,
            child: Image.asset('assets/hospital.png', width: 100, height: 100),
          ),
        ),
        Positioned(
          top: 580,
          left: 160,
          height: 70,
          width: 230,
          child: Container(
            width: 177,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Esculab",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.51),
                  fontSize: 22,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(209, 229, 231, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18), // Зменшуємо радіус заокруглення кутів
                  ),
                ),
                alignment: Alignment.centerLeft, // Вирівнювання тексту по центру кнопки
              ),
            ),
          ),
        ),


        Positioned(
          top: 560,
          left: 310,
          child: Transform.scale(
            scale: 0.5,
            child: Image.asset('assets/hospital.png', width: 100, height: 100),
          ),
        ),

      ],
    );
  }
}

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final Color backgroundColor;
  final Color textColor;

  RoundButton(
      this.text,
      this.onPressed, {
        this.width = 177,
        this.backgroundColor = Colors.blue,
        this.textColor = Colors.white,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 57,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(backgroundColor),
        ),
      ),
    );
  }
}
class CustomMyRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Positioned(
      top:0,
      left:0,
      child: Container(

        width: 350,
        height: 900,
        color: const Color.fromRGBO(245, 245, 245, 1),
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: -5,
              child: Transform.scale(
                scale: 0.7,
                child: Elipse(
                  width: 150,
                  height: 130,
                  color: Colors.blue,
                ),
              ),
            ),
            Positioned(
              top: -33,
              left: -55,
              child: Transform.scale(
                scale: 0.61,
                child: Image.asset(
                  'assets/4.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 135,
              child: Text(
                'Імʼя',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: -20,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage ()),
                  );
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
              top: 130,
              left: 135,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Text(
                  'Подивитись профіль',
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(128, 128, 128, 1),
                    height: 23 / 20,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 265,
              left:67,
              child: Transform.scale(
                scale: 2.43,
                child: Image.asset('assets/q.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 345,
              left: 67,
              child: Transform.scale(
                scale: 2.43,
                child: Image.asset('assets/people.png', width: 100, height: 100),
              ),
            ),
            Positioned(
              top: 236,
              left: 100,
              child: Text(
                'Банк крові',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(128, 128, 128, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 305,
              left: 100,
              child: Text(
                'Допомога',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(128, 128, 128, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Positioned(
              top: 385,
              left: 100,
              child: Text(
                'Про нас',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(128, 128, 128, 1),
                  height: 23 / 20,
                  letterSpacing: 0,
                ),
              ),
            ),
            Container(
              width: 356,
              height: 1,
              margin: EdgeInsets.only(top: 180),
              color: Color.fromRGBO(143, 142, 142, 1),
            ),
            Positioned(
              top: 178,
              left: -44,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BloodPage()),
                  );
                  print('Blood button clicked');
                },
                child: Transform.scale(
                  scale: 0.9,
                  child: Image.asset(
                    'assets/blood.png',
                    fit: BoxFit.cover, // Fixes border issues
                    width: 320,
                    height: 110,
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

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  int selectedMonthIndex = DateTime.now().month - 1; // Початковий вибраний місяць
  int selectedDayIndex = DateTime.now().day - 1; // Початковий вибраний день

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Container(
            height: 100,
            width: screenWidth, // Використовуємо ширину екрану
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 12, // Кількість місяців
              itemBuilder: (context, index) {
                final currentMonth = DateFormat('MMMM').format(DateTime(DateTime.now().year, index + 1));
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMonthIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          currentMonth, // Назва місяця повним словом
                          style: TextStyle(
                            color: index == selectedMonthIndex ? Colors.black : const Color.fromRGBO(0, 0, 0, 0.5),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto Flex',
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 95,
            width: screenWidth, // Використовуємо ширину екрану
            decoration: BoxDecoration(
              color: const Color.fromRGBO(34, 151, 161, 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: DateTime(DateTime.now().year, selectedMonthIndex + 1, 0).day, // Кількість днів у обраному місяці
              itemBuilder: (context, index) {
                final currentDate = DateTime(DateTime.now().year, selectedMonthIndex + 1, index + 1);
                final dayOfWeek = DateFormat.E().format(currentDate); // Форматуємо день тижня
                final dayOfMonth = (index + 1).toString().padLeft(2, '0'); // Форматуємо день місяця
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dayOfWeek, // Назва дня тижня
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 0, 0, 0.5),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto Flex',
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 4),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Text(
                              dayOfMonth, // Вивести номер дня у форматі двозначного числа
                              style: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto Flex',
                                fontSize: 22,
                              ),
                            ),
                            if (index == selectedDayIndex)
                              Container(
                                width: 20, // Ширина лінії підкреслення
                                height: 2, // Висота лінії підкреслення
                                color: const Color.fromRGBO(34, 151, 161, 1), // Колір лінії підкреслення
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
