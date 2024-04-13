import 'package:flutter/material.dart';
import 'package:flutter_application_1/displays/upload.dart';
import 'Profile.dart';
import 'blood_bank.dart';
import 'homepage.dart';
import 'statistic.dart';
import 'uploadlook.dart';
import 'noevent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NofilePage(),
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

class NofilePage extends StatefulWidget {
  @override
  _NofileState createState() => _NofileState();
}


class _NofileState extends State<NofilePage> {
  bool _menuVisibility = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
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

                //Navigator.push(context, MaterialPageRoute(builder: (context) => CustomMyRectangle(width: width, height: height)));
                print('Menu Clicked');
              },
              child: Image.asset(
                'assets/menu.jpg',
                width: 45,
                height: 40,
              ),
            ),
          ),
          Positioned(
            top: 158,
            left: 0,
            right: 0,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton(
                  "Додати документи",
                      () {
                    {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadPage()),
                    );}
                  },
                  width: 248, // Встановіть бажану ширину
                ),
                RoundButton(
                  "Статистика",
                      () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StatisticsPage()),
                      );
                  },
                  width: 248, // Встановіть бажану ширину
                ),
              ],
            ),
          ),
          Positioned(
              top: 325,
              left: -55,
              child:TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadLookPage()),
                  );
                  print('Analusis 1 button clicked');

                }, // Image tapped
                child: Image.asset(
                  'assets/bluefile.png',
                  fit: BoxFit.cover, // Fixes border issues
                  width:255,
                  height: 216,
                ),
              )
          ),



          // Positioned(
          //   top: 335,
          //   left: -65,
          //   width: 300,
          //   height: 216,
          //   child: Transform.scale(
          //     scale: 1,
          //     child: Image.asset('assets/bluefile.png', width: 100, height: 100),
          //   ),
          // ),
          Positioned(
            top: 440,
            left: 58,
            child: Text(
              'Аналізи 1',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
              top: 325,
              left: 140,
              child:TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadLookPage()),
                  );
                  print('Analusis 2 button clicked');

                }, // Image tapped
                child: Image.asset(
                  'assets/bluefile.png',
                  fit: BoxFit.cover, // Fixes border issues
                  width:255,
                  height: 216,
                ),
              )
          ),
          Positioned(
            top: 440,
            left: 252,
            child: Text(
              'Аналізи 2',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 91,
            child: Text(
              'Дата',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(0, 0, 0, 0.77),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 286,
            child: Text(
              'Дата',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(0, 0, 0, 0.77),
                height: 23 / 20,
                letterSpacing: 0,
              ),
            ),
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
            left: 130,
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
            left: 225,
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
            top: 587,
            left: -80,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
                print('Calendar Clicked');
              },
              child: Transform.scale(
                scale: 0.1,
                child: Image.asset('assets/calendar.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 793,
            left: 30,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                print('Home Clicked');
              },
              child: Transform.scale(
                scale: 0.59,
                child: Image.asset('assets/home.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 765,
            left: 268,
            child: GestureDetector(
              child: Transform.scale(
                scale: 0.5,
                child: Image.asset('assets/probirka.jpg'),
              ),
            ),
          ),

          if(_menuVisibility) CustomMyRectangle()
        ],
      ),
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
        this.width = 200,
        this.backgroundColor = const Color.fromRGBO(34, 151, 161, 1),
        this.textColor = Colors.white,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor,
            fontFamily: 'Roboto Flex',
            fontSize: 22,
            fontWeight: FontWeight.w400,),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
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
                    MaterialPageRoute(builder: (context) => NofilePage()),
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
